return {
  dir = vim.fn.stdpath("config") .. "/local-plugins/floating-lazygit",
  event = "VeryLazy",
  keys = {
    {
      "<C-_>",
      function()
        require("floating-lazygit").toggle_lazygit()
      end,
      desc = "Toggle Floating Lazygit",
      mode = { "n", "t" }, -- support both normal and terminal mode
    },
  },
  config = function()
    require("floating-lazygit").setup()
  end,
}
