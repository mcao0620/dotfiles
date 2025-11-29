-- Add this to your existing gitsigns.nvim configuration
-- Only the additional PR browsing functionality

return {
  "lewis6991/gitsigns.nvim",
  opts = {
    current_line_blame = true,
    on_attach = function(bufnr)
      local gs = require("gitsigns")
      -- Helper function to open PR in browser
      local function open_pr_in_browser(pr_number)
        local cmd = { "gh", "browse", pr_number }

        vim.system(cmd, { text = true }, function(result)
          vim.schedule(function()
            if result.code == 0 then
              vim.notify("Opened PR #" .. pr_number .. " in browser", vim.log.levels.INFO)
            else
              vim.notify("Failed to open PR #" .. pr_number .. " in browser", vim.log.levels.ERROR)
            end
          end)
        end)
      end

      -- Function to get current line blame info and open associated PR
      local function browse_current_line_pr()
        -- Check if gh CLI is available
        if vim.fn.executable("gh") == 0 then
          vim.notify("GitHub CLI (gh) is not installed or not in PATH", vim.log.levels.ERROR)
          return
        end

        -- Use blame_line popup to get commit info
        gs.blame_line({ full = false }, function()
          gs.blame_line({}, function()
            vim.schedule(function()
              -- Get line 2 which contains the commit message
              local commit_message = vim.fn.getline(2)

              vim.cmd("close")

              if commit_message and commit_message ~= "" then
                -- Extract PR number from format like: [NI][Workflows] Implement planning for the splitter step (#152333)
                local pr_number = commit_message:match("%(#(%d+)%)")

                if pr_number then
                  open_pr_in_browser(pr_number)
                else
                  vim.notify("No PR number found in commit message: " .. commit_message, vim.log.levels.WARN)
                end
              else
                vim.notify("No commit message found", vim.log.levels.WARN)
              end
            end)
          end)
        end)
      end

      -- PR browsing keymap
      vim.keymap.set(
        "n",
        "<leader>gpr",
        browse_current_line_pr,
        { desc = "Browse to PR for current line", buffer = bufnr }
      )
    end,
  },
}
