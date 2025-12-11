local is_git_ignored = function(filepath)
  vim.fn.system("git check-ignore -q " .. vim.fn.shellescape(filepath))
  return vim.v.shell_error == 0
end

local update_left_pane = function()
  pcall(function()
    local lib = require("diffview.lib")
    local view = lib.get_current_view()
    if view then
      view:update_files()
    end
  end)
end

-- Register directory watcher handler for auto-refreshing diffview
pcall(function()
  require("custom.directory-watcher").registerOnChangeHandler("diffview", function(filepath)
    local is_in_dot_git_dir = filepath:match("/%.git/") or filepath:match("^%.git/")
    if is_in_dot_git_dir or not is_git_ignored(filepath) then
      update_left_pane()
    end
  end)
end)

vim.api.nvim_create_autocmd("FocusGained", { callback = update_left_pane })
vim.api.nvim_create_autocmd("User", {
  pattern = "DiffviewViewLeave",
  callback = function()
    vim.cmd(":DiffviewClose")
  end,
})

return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewClose" },
  config = function()
    require("diffview").setup({
      default_args = {
        DiffviewOpen = { "--imply-local" },
      },
      keymaps = {
        view = {
          { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close diffview" } },
        },
        file_panel = {
          { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close diffview" } },
        },
        file_history_panel = {
          { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close diffview" } },
        },
      },
    })
  end,
  keys = function()
    local actions = require("diffview.actions")

    return {
      { "<leader>do", "<cmd>DiffviewOpen<cr>", desc = "Diffview Open" },
      { "<leader>dc", "<cmd>DiffviewClose<cr>", desc = "Diffview Close" },

      {
        "<leader>dm",
        function()
          local base = vim.fn.systemlist("git merge-base HEAD origin/master")[1]

          if not base or base == "" then
            vim.notify("No merge-base for HEAD and origin/master", vim.log.levels.ERROR)
            return
          end

          vim.cmd("DiffviewOpen " .. base)
        end,
        desc = "Diff vs merge-base (origin/master)",
      },

      {
        "]g",
        actions.select_next_entry,
        desc = "Next diff file",
      },
      {
        "[g",
        actions.select_prev_entry,
        desc = "Prev diff file",
      },
    }
  end,
}
