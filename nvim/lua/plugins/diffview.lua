return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewClose" },
  opts = {},
  keys = function()
    local actions = require("diffview.actions")

    return {
      { "<leader>do", "<cmd>DiffviewOpen<cr>", desc = "Diffview Open" },
      { "<leader>dc", "<cmd>DiffviewClose<cr>", desc = "Diffview Close" },

      {
        "<leader>dm",
        function()
          -- Get merge base of HEAD and origin/master
          local base = vim.fn.systemlist("git merge-base HEAD origin/master")[1]

          if not base or base == "" then
            vim.notify("No merge-base for HEAD and origin/master", vim.log.levels.ERROR)
            return
          end

          -- Open diff from merge-base to current working tree
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
