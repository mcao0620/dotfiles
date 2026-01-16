return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      gopls = {
        settings = {
          gopls = {
            -- Enable Bazel support
            ["build.buildFlags"] = { "-tags=bazel" },
            env = {
              GOPACKAGESDRIVER = vim.fn.fnamemodify("./tools/gopackagesdriver.sh", ":p"),
            },
            hints = {
              assignVariableTypes = false,
              compositeLiteralFields = false,
              compositeLiteralTypes = false,
              constantValues = false,
              functionTypeParameters = false,
              parameterNames = false,
              rangeVariableTypes = false,
            },
            directoryFilters = {
              "-.bazel",
              "-bazel-bin",
              "-bazel-out",
              "-bazel-testlogs",
              "-bazel-LOMP",
              "-bazel-com_github_askscio_scio",
            },
          },
        },
      },
      vtsls = {
        settings = {
          typescript = {
            inlayHints = {
              enumMemberValues = { enabled = false },
              functionLikeReturnTypes = { enabled = false },
              parameterNames = { enabled = "literals" },
              parameterTypes = { enabled = false },
              propertyDeclarationTypes = { enabled = false },
              variableTypes = { enabled = false },
            },
          },
        },
      },
      yamlls = {
        settings = {
          yaml = {
            format = {
              enable = false,
            },
          },
        },
      },
      buf_ls = {
        on_attach = function(client, _)
          -- Disable formatting capabilities for buf_ls
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end,
      },
    },
  },
}
