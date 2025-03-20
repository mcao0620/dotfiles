---@diagnostic disable-next-line: unused-local
local function generate_slash_commands()
  local commands = {}
  local picker = LazyVim.pick.picker.name == "fzf" and "fzf_lua" or LazyVim.pick.picker.name
  for _, command in ipairs({ "buffer", "file", "help", "symbols" }) do
    commands[command] = {
      opts = {
        provider = picker, -- dynamically resolve the provider
      },
    }
  end
  return commands
end

return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      { "MeanderingProgrammer/render-markdown.nvim", ft = { "markdown", "codecompanion" } },
      "j-hui/fidget.nvim",
    },
    opts = {
      strategies = {
        chat = {
          adapter = "openai",
          roles = {
            llm = "CodeCompanion",
            user = "Me",
          },
          slash_commands = generate_slash_commands(),
          keymaps = {
            close = {
              modes = {
                n = "q",
              },
              index = 3,
              callback = "keymaps.close",
              description = "Close Chat",
            },
            stop = {
              modes = {
                n = "<C-c",
              },
              index = 4,
              callback = "keymaps.stop",
              description = "Stop Request",
            },
          },
        },
      },
      inline = {
        adapter = "openai",
      },
      adapters = {
        openai = function()
          return require("codecompanion.adapters").extend("openai", {
            env = {
              api_key = "cmd:cat $HOME/.openaikey",
            },
            -- schema = {
            --   model = {
            --     default = "",
            --   },
            -- },
          })
        end,
      },
      log_level = "DEBUG",
    },
    keys = {
      {
        "<leader>aa",
        "<cmd>CodeCompanionActions<cr>",
        mode = { "n", "v" },
        noremap = true,
        silent = true,
        desc = "CodeCompanion actions",
      },
      {
        "<leader>ac",
        "<cmd>CodeCompanionChat Toggle<cr>",
        mode = { "n", "v" },
        noremap = true,
        silent = true,
        desc = "CodeCompanion chat",
      },
      {
        "<leader>ad",
        "<cmd>CodeCompanionChat Add<cr>",
        mode = "v",
        noremap = true,
        silent = true,
        desc = "CodeCompanion add to chat",
      },
      {
        "<leader>ai",
        "<cmd>CodeCompanionActions<cr>in",
        mode = "v",
        noremap = true,
        silent = true,
        desc = "CodeCompanion add to chat",
      },
    },
    init = function()
      require("plugins.codecompanion.fidget-spinner"):init()
    end,
  },
  {
    "saghen/blink.cmp",
    opts = {
      sources = {
        default = { "codecompanion" },
        providers = {
          codecompanion = {
            name = "CodeCompanion",
            module = "codecompanion.providers.completion.blink",
            enabled = true,
          },
        },
      },
    },
  },
}
