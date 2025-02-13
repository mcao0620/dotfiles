return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      gopls = {
        settings = {
          gopls = {
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
              "-bazel-bin",
              "-bazel-out",
              "-bazel-testlogs",
              "-bazel-LOMP",
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
              -- printWidth = 120,
              -- proseWrap = "always",
              -- singleQuote = true,
            },
            -- schemas = {
            --   ["https://spec.openapis.org/oas/3.0/schema/2021-09-28"] = "openapi/**/*.yaml",
            -- },
          },
        },
      },
    },
  },
}
