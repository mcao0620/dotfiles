-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Set column width lines for different file types
vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    vim.opt_local.colorcolumn = { 104 }
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "typescript", "typescriptreact" },
  callback = function()
    vim.opt_local.colorcolumn = { 124 }
  end,
})
-- Auto-save and reload setup for Claude Code workflow
function _G.format_after_cli_cmd()
  local bufnr = vim.api.nvim_get_current_buf()
  if not vim.api.nvim_get_option_value("modified", { buf = bufnr }) then
    return
  end
  vim.cmd("silent! write")
  vim.system({ "sh", "-c", stylua_cmd(vim.api.nvim_buf_get_name(bufnr)) }, {}, function(obj)
    if obj.code ~= 0 then
      return logger.error(obj.stderr)
    end
    vim.schedule(function()
      vim.api.nvim_command(":checktime")
    end)
  end)
end
