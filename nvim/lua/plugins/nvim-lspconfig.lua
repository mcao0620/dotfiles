return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      gopls = {
        settings = {
          gopls = {
            env = {
              GOPACKAGESDRIVER = "/Users/michaelcao/workspace/scio/tools/gopackagesdriver.sh",
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
    },
  },
}
