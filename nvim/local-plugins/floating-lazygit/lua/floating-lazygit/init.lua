local M = {}

local state = {
  floating = {
    buf = -1,
    win = -1,
  },
  augroup = nil,
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
  }

  -- Create the floating window
  local win = vim.api.nvim_open_win(buf, true, win_config)

  return { buf = buf, win = win }
end

local function clear_focus_autocmd()
  if state.augroup then
    vim.api.nvim_del_augroup_by_id(state.augroup)
    state.augroup = nil
  end
end

local function setup_tmux_navigation_keymaps(buf)
  if not vim.env.TMUX then
    return
  end

  local tmux_directions = {
    ["<C-h>"] = "L",
    ["<C-j>"] = "D",
    ["<C-k>"] = "U",
    ["<C-l>"] = "R",
  }

  for key, direction in pairs(tmux_directions) do
    vim.keymap.set("t", key, function()
      vim.fn.system("tmux select-pane -" .. direction)
    end, { buffer = buf, desc = "Navigate to tmux pane" })
  end
end

local function setup_focus_autocmd()
  if state.augroup then
    return
  end

  state.augroup = vim.api.nvim_create_augroup("FloatingLazygitFocus", { clear = true })

  vim.api.nvim_create_autocmd("FocusGained", {
    group = state.augroup,
    callback = function()
      if vim.api.nvim_win_is_valid(state.floating.win) then
        vim.api.nvim_set_current_win(state.floating.win)
        vim.cmd.startinsert()
      end
    end,
  })

  vim.api.nvim_create_autocmd("WinClosed", {
    group = state.augroup,
    callback = function(args)
      if tonumber(args.match) == state.floating.win then
        clear_focus_autocmd()
      end
    end,
  })
end

local function toggle_lazygit()
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    state.floating = create_floating_window({ buf = state.floating.buf })
    if vim.bo[state.floating.buf].buftype ~= "terminal" then
      vim.fn.jobstart("lazygit", { term = true })
      setup_tmux_navigation_keymaps(state.floating.buf)
    end
    setup_focus_autocmd()
    vim.cmd.startinsert()
  else
    clear_focus_autocmd()
    vim.api.nvim_win_hide(state.floating.win)
  end
end

function M.setup()
  -- Create user command
  vim.api.nvim_create_user_command("FloatingLazygitToggle", toggle_lazygit, {})
end

M.toggle_lazygit = toggle_lazygit

return M
