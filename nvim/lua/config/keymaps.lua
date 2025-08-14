-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<C-h>", "<Cmd>TmuxNavigateLeft<CR>", { silent = true })
vim.keymap.set("n", "<C-j>", "<Cmd>TmuxNavigateDown<CR>", { silent = true })
vim.keymap.set("n", "<C-k>", "<Cmd>TmuxNavigateUp<CR>", { silent = true })
vim.keymap.set("n", "<C-l>", "<Cmd>TmuxNavigateRight<CR>", { silent = true })

vim.keymap.set(
  "n",
  "<leader>sx",
  require("telescope.builtin").resume,
  { noremap = true, silent = true, desc = "Resume" }
)

vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<A-j>", "")
vim.keymap.set("n", "<A-k>", "")

-- bazel
-- local bazel = require("bazel")
-- local my_bazel = require("config.bazel")
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "bzl",
--   callback = function()
--     vim.keymap.set("n", "gd", vim.fn.GoToBazelDefinition, { buffer = true, desc = "Goto Definition" })
--   end,
-- })
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "bzl",
--   callback = function()
--     vim.keymap.set("n", "<Leader>y", my_bazel.YankLabel, { desc = "Bazel Yank Label" })
--   end,
-- })
-- vim.keymap.set("n", "gzt", vim.fn.GoToBazelTarget, { desc = "Goto Bazel Build File" })
-- vim.keymap.set("n", "<Leader>zl", bazel.run_last, { desc = "Bazel Last" })
-- vim.keymap.set("n", "<Leader>zdt", my_bazel.DebugTest, { desc = "Bazel Debug Test" })
-- vim.keymap.set("n", "<Leader>zdr", my_bazel.DebugRun, { desc = "Bazel Debug Run" })
-- vim.keymap.set("n", "<Leader>zt", function()
--   bazel.run_here("test", vim.g.bazel_config)
-- end, { desc = "Bazel Test" })
-- vim.keyamp.set("n", "<Leader>zb", function()
--   bazel.run_here("build", vim.g.bazel_config)
-- end, { desc = "Bazel Build" })
-- vim.keymap.set("n", "<Leader>zr", function()
--   bazel.run_here("run", vim.g.bazel_config)
-- end, { desc = "Bazel Run" })
-- vim.keymap.set("n", "<Leader>zdb", function()
--   bazel.run_here("build", vim.g.bazel_config .. " --compilation_mode dbg --copt=-O0")
-- end, { desc = "Bazel Debug Build" })
-- vim.keymap.set("n", "<Leader>zda", my_bazel.set_debug_args_from_input, { desc = "Set Bazel Debug Arguments" })
