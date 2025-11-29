return {
  "Wansmer/treesj",
  keys = {
    {
      "<leader>tt",
      function()
        require("treesj").toggle()
      end,
    },
  },
  dependencies = { "nvim-treesitter/nvim-treesitter" }, -- if you install parsers with `nvim-treesitter`
  config = function()
    require("treesj").setup({--[[ your config ]]
    })
  end,
}
