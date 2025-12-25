return {
  "snacks.nvim",
  keys = {
    {
      "<leader>gm",
      function()
        require("snacks.gitbrowse")({
          what = "file",
          branch = "master",
        })
      end,
      desc = "Open current file on master (with line number) in browser",
      mode = { "n", "v" }, -- support both normal and visual mode
    },
  },
  opts = {
    scroll = { enabled = false },
  },
}
