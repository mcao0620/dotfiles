-- when running `nvim my/folder` sets cwd to be my/folder
-- https://www.reddit.com/r/neovim/comments/t26htu/comment/hynjpru/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
if vim.fn.isdirectory(vim.v.argv[3]) == 1 then
  vim.api.nvim_set_current_dir(vim.v.argv[3])
end

-- Always watch cwd for file changes (enables hotreload, diffview refresh, etc.)
require("custom.directory-watcher").setup({
  path = vim.fn.getcwd(),
  debounce = 100,
})

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
