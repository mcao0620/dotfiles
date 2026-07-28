-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set({ "n", "v", "i", "t" }, "<C-h>", "<Cmd>TmuxNavigateLeft<CR>", { silent = true })
vim.keymap.set({ "n", "v", "i", "t" }, "<C-j>", "<Cmd>TmuxNavigateDown<CR>", { silent = true })
vim.keymap.set({ "n", "v", "i", "t" }, "<C-k>", "<Cmd>TmuxNavigateUp<CR>", { silent = true })
vim.keymap.set({ "n", "v", "i", "t" }, "<C-l>", "<Cmd>TmuxNavigateRight<CR>", { silent = true })

vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<leader>ww", "<CMD>:w!<CR>")
vim.keymap.set("n", "<A-j>", "")
vim.keymap.set("n", "<A-k>", "")
vim.keymap.set("n", "<S-j>", "")

-- vim.keymap.set("n", "<leader><space>", function()
--   require("lazyvim.util").pick("files", { root = false })
-- end, { desc = "Find Files (cwd)" })
--
-- Robust argument splitter for one-line function calls.
-- Allows trailing ., method-chains, comments, etc.

local function split_args_line()
  local line = vim.api.nvim_get_current_line()
  if not line or line:match("^%s*$") then
    return
  end

  -- Capture indent, function name, args, and trailing text
  -- Accepts lines like:
  --   Func(arg1, arg2).Something()
  --   Foo(a,b) // comment
  --   Bar(x,y,z)   .
  local indent, func, argstr, trailing = line:match("^(%s*)([%w_%.:]+)%s*%((.*)%)%s*(.-)%s*$")

  if not func or not argstr then
    vim.notify("SplitArgs: current line doesn't look like a function call", vim.log.levels.INFO)
    return
  end

  -- Split args by top-level commas
  local function split_args_str(s)
    local args = {}
    local current = {}
    local depth = 0

    local function push_current()
      local raw = table.concat(current)
      if raw:match("%S") then
        table.insert(args, vim.trim(raw))
      end
      current = {}
    end

    for i = 1, #s do
      local c = s:sub(i, i)
      if c == "(" or c == "[" or c == "{" then
        depth = depth + 1
        table.insert(current, c)
      elseif c == ")" or c == "]" or c == "}" then
        depth = depth - 1
        table.insert(current, c)
      elseif c == "," and depth == 0 then
        push_current()
      else
        table.insert(current, c)
      end
    end

    push_current()
    return args
  end

  local args = split_args_str(argstr)
  if #args == 0 then
    vim.notify("SplitArgs: no args found", vim.log.levels.INFO)
    return
  end

  local new_lines = {}
  table.insert(new_lines, indent .. func .. "(")

  local arg_indent = indent .. "    "

  for _, a in ipairs(args) do
    table.insert(new_lines, arg_indent .. a .. ",")
  end

  table.insert(new_lines, indent .. ")" .. (trailing ~= "" and " " .. trailing or ""))

  local row = vim.api.nvim_win_get_cursor(0)[1] - 1
  vim.api.nvim_buf_set_lines(0, row, row + 1, false, new_lines)
end

vim.keymap.set("n", "<leader>ts", split_args_line, { desc = "Split function args on current line" })

-- Join lines using count, like J
local function join_with_count(count)
  count = count or vim.v.count1 + 1
  vim.cmd("normal! " .. count .. "J")
end

-- Map <leader>sj as a count-aware join
vim.keymap.set("n", "<leader>jl", function()
  join_with_count()
end, { desc = "Join lines with count" })

vim.keymap.set("n", "<leader>yp", function()
  local path = vim.fn.expand("%")
  vim.fn.setreg("+", path)
  vim.notify(path, vim.log.levels.INFO)
end, { desc = "Yank relative file path" })

vim.keymap.set("n", "<leader>mg", function()
  local clients = vim.lsp.get_clients({ name = "gopls" })
  if #clients > 0 then
    vim.lsp.enable("gopls", false)
    for _, client in ipairs(clients) do
      vim.lsp.stop_client(client.id)
    end
    vim.notify("gopls stopped", vim.log.levels.INFO)
  else
    vim.lsp.enable("gopls", true)
    vim.notify("gopls started", vim.log.levels.INFO)
  end
end, { desc = "Toggle gopls" })

vim.keymap.set("n", "<leader>o", function()
  local file = vim.fn.expand("%:p")
  if file == "" then
    vim.notify("No file to open", vim.log.levels.WARN)
    return
  end
  local filename = vim.fn.fnamemodify(file, ":t")
  local vault = vim.fn.expand("~/Documents/Obsidian Vault")
  local dest = vault .. "/" .. filename
  vim.fn.system({ "cp", file, dest })
  vim.fn.system({ "open", "obsidian://open?vault=Obsidian Vault&file=" .. vim.uri_encode(filename) })
end, { desc = "Copy file to Obsidian vault and open" })
