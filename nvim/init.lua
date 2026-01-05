_G.vim = vim
vim.g.mapleader = ' '
-- Native keymaps
local keymap = vim.keymap.set
keymap('n', '<leader>r', ':so<CR>')
keymap('n', '<leader>qq', ':x<CR>')
keymap('n', '<C-d>', '<C-d>zz')
keymap('n', '<C-u>', '<C-u>zz')
keymap({ 'n', 'x' }, '<leader>y', '\"+y')
keymap('n', '<leader>bd', ':bdelete<CR>')
keymap('n', '<leader>q', '<C-w>c')
keymap('n', 'L', ':bnext<CR>')
keymap('n', 'H', ':bprev<CR>')
keymap('n', '<leader>wd', ':close<CR>')
keymap('n', '<leader>-', ':split<CR>')
keymap('n', '<leader>|', ':vsplit<CR>')
keymap('n', '<leader>ww', ':w!<CR>')
keymap({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action)

keymap('n', '<leader>lf', vim.lsp.buf.format)

-- Native opts
local opt = vim.o
opt.number = true
opt.relativenumber = true
opt.wrap = false
opt.shiftwidth = 2
opt.tabstop = 2
opt.scrolloff = 4
opt.cursorline = false
opt.ignorecase = true
opt.smartcase = true
opt.clipboard = 'unnamedplus'
opt.swapfile = false
opt.grepprg = 'rg --vimgrep --no-messages --smart-case'
opt.statusline = '[%n] %f %m %r %= %{v:lua.git_branch()} %l:%c'

-- Packages
vim.pack.add({
	{ src = 'https://github.com/williamboman/mason.nvim' },
	{ src = 'https://github.com/neovim/nvim-lspconfig' },
	{ src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
	{ src = 'https://github.com/ibhagwan/fzf-lua' },
	{ src = 'https://github.com/christoomey/vim-tmux-navigator' },
})

-- LSP
require('mason').setup()
vim.lsp.enable({ 'lua_ls' })
vim.lsp.on_type_formatting.enable()

-- fzf-lua
local fzf_lua = require('fzf-lua')
fzf_lua.register_ui_select()
fzf_lua.setup({
	opts = {
		oldfiles = {
			include_current_session = true,
		},
		previewers = {
			builtin = {
				syntax_limit_b = 1024 * 100,
			},
		},
	},
	keymap = {
		fzf = {
			['ctrl-q'] = 'select-all+accept', -- send all items to quickfix
		},
	},
})
keymap('n', '<leader><leader>', fzf_lua.files)
keymap('n', '<leader>,', fzf_lua.buffers)
keymap('n', '<leader>fq', fzf_lua.quickfix)
keymap('n', '<leader>fr', fzf_lua.oldfiles)
-- grep
keymap('n', '<leader>/', fzf_lua.live_grep_native)
keymap('n', '<leader>gr', function() fzf_lua.live_grep({ resume = true }) end)
keymap('n', '<leader>gg', fzf_lua.grep)

-- Autocommands
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
autocmd('TextYankPost', {
	pattern = '*',
	callback = function()
		vim.highlight.on_yank({ timeout = 170 })
	end,
	group = augroup('YankHighlight', { clear = true }),
})

-- when running `nvim my/folder` sets cwd to be my/folder
-- https://www.reddit.com/r/neovim/comments/t26htu/comment/hynjpru/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
if vim.fn.isdirectory(vim.v.argv[3]) == 1 then
	vim.api.nvim_set_current_dir(vim.v.argv[3])
end

-- Always watch cwd for file changes (enables hotreload, diffview refresh, etc.)
require('custom.directory-watcher').setup({
	path = vim.fn.getcwd(),
	debounce = 100,
})


function _G.git_branch()
	local handle = io.popen('git branch --show-current 2>/dev/null')
	if handle == nil then
		return ''
	end
	local result = handle:read('*a') or ''
	handle:close()
	result = result:gsub('%s+', '') -- trim
	if result == '' then
		return ''
	end
	return ' ' .. result .. ' '
end
