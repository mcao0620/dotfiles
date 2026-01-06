return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    signs = true,
    keywords = {
      TODO = { icon = " ", color = "info", alt = { "todo", "Todo", "TODOS" } },
      NOTE = { icon = " ", color = "hint", alt = { "note", "Note" } },
    },
    highlight = {
      multiline = false,
      keyword = "wide_fg",
      after = "fg",
      pattern = [[.*<((KEYWORDS)%(\([^)]*\))?):]],
      comments_only = true,
    },
    search = {
      pattern = [[\b(KEYWORDS)(\([^)]*\))?:]],
      args = {
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--ignore-case",
      },
    },
  },
}
