local M = {}

local state = {
  floating = {
    buf = -1,
    win = -1,
  },
}

local function create_floating_window(opts)
  opts = opts or {}
  local width = opts.width or math.floor(vim.o.columns * 0.9)
  local height = opts.height or math.floor(vim.o.lines * 0.9)

  -- Calculate the position to center the window
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  -- Create a buffer
  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
  end

  -- Define window configuration
  local win_config = {
    relative = "editor",
    width = width,
    height = height,
    col = col,
    row = row,
    style = "minimal", -- No borders or extra UI elements
    -- border = "rounded",
  }

  -- Create the floating window
  local win = vim.api.nvim_open_win(buf, true, win_config)

  return { buf = buf, win = win }
end

local function toggle_lazygit()
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    state.floating = create_floating_window({ buf = state.floating.buf })
    if vim.bo[state.floating.buf].buftype ~= "terminal" then
      vim.fn.termopen("lazygit")
    end
    -- Set buffer-local keymap to hide terminal with "q" in terminal mode
    vim.keymap.set("t", "q", function()
      vim.api.nvim_win_hide(state.floating.win)
    end, { buffer = state.floating.buf, desc = "Hide floating lazygit" })
    -- vim.keymap.set("t", "<C-.>", function()
    --   vim.api.nvim_win_hide(state.floating.win)
    -- end, { buffer = state.floating.buf, desc = "Hide floating lazygit" })
    -- Start in insert mode (terminal mode)
    vim.cmd.startinsert()
  else
    vim.api.nvim_win_hide(state.floating.win)
  end
end

function M.setup()
  -- Create user command
  vim.api.nvim_create_user_command("FloatingLazygitToggle", toggle_lazygit, {})

  -- Set up keymap
  vim.keymap.set("n", "<leader>gg", toggle_lazygit, { desc = "Toggle floating lazygit" })
end

M.toggle_lazygit = toggle_lazygit

return M
