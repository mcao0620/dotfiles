-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<C-h>", "<Cmd>TmuxNavigateLeft<CR>", { silent = true })
vim.keymap.set("n", "<C-j>", "<Cmd>TmuxNavigateDown<CR>", { silent = true })
vim.keymap.set("n", "<C-k>", "<Cmd>TmuxNavigateUp<CR>", { silent = true })
vim.keymap.set("n", "<C-l>", "<Cmd>TmuxNavigateRight<CR>", { silent = true })

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    if opts.remap and not vim.g.vscode then
      opts.remap = nil
    end
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

local function callVSCodeFunction(vsCodeCommand)
  vim.cmd(vsCodeCommand)
end

local function vscodeMappings()
  map("n", "<leader>cs", function()
    print("go to symbols in editor")
    callVSCodeFunction("call VSCodeCall('workbench.action.gotoSymbol')")
  end, { noremap = true, silent = true, desc = "go to symbols in editor" })

  map("n", "gr", function()
    callVSCodeFunction("call VSCodeNotify('editor.action.referenceSearch.trigger')")
  end, { noremap = true, desc = "peek references inside vs code" })

  map("n", "<leader>sd", function()
    callVSCodeFunction("call VSCodeNotify('workbench.action.problems.focus')")
  end, { noremap = true, desc = "open problems and errors infos" })

  map("n", "<leader>e", function()
    callVSCodeFunction("call VSCodeNotify('workbench.files.action.focusFilesExplorer')")
  end, { noremap = true, desc = "focus to file explorer" })

  map("n", "<leader>fe", function()
    callVSCodeFunction("call VSCodeNotify('workbench.files.action.focusFilesExplorer')")
  end, { noremap = true, desc = "focus to file explorer" })

  map("n", "<leader>ff", function()
    callVSCodeFunction("call VSCodeNotify('workbench.action.quickOpen')")
  end, { noremap = true, desc = "open files" })

  map("n", "<leader>gg", function()
    callVSCodeFunction("call VSCodeNotify('workbench.view.scm')")
  end, { noremap = true, desc = "open git source control" })

  -- map("n", "<leader>sml", function()
  --   callVSCodeFunction("call VSCodeNotify('bookmarks.list')")
  -- end, { noremap = true, desc = "open bookmarks list for current files" })

  -- map("n", "<leader>smL", function()
  --   callVSCodeFunction("call VSCodeNotify('bookmarks.listFromAllFiles')")
  -- end, { noremap = true, desc = "open bookmarks list for all files" })

  -- map("n", "<leader>smm", function()
  --   callVSCodeFunction("call VSCodeNotify('bookmarks.toggle')")
  -- end, { noremap = true, desc = "toggle bookmarks" })

  -- map("n", "<leader>smd", function()
  --   callVSCodeFunction("call VSCodeNotify('bookmarks.clear')")
  -- end, { noremap = true, desc = "clear bookmarks from current file" })

  -- map("n", "<leader>smr", function()
  --   callVSCodeFunction("call VSCodeNotify('bookmarks.clearFromAllFiles')")
  -- end, { noremap = true, desc = "clear bookmarks from all file" })

  map("n", "<leader>cr", function()
    callVSCodeFunction("call VSCodeNotify('editor.action.rename')")
  end, { noremap = true, desc = "rename symbol" })

  map("n", "<leader>ca", function()
    callVSCodeFunction("call VSCodeNotify('editor.action.quickFix')")
  end, { noremap = true, desc = "open quick fix in vs code" })

  map("n", "<leader>cA", function()
    callVSCodeFunction("call VSCodeNotify('editor.action.sourceAction')")
  end, { noremap = true, desc = "open source Action in vs code" })

  map("n", "<leader>cp", function()
    callVSCodeFunction("call VSCodeNotify('workbench.panel.markers.view.focus')")
  end, { noremap = true, desc = "open problems diagnostics" })

  map("n", "<leader>cd", function()
    callVSCodeFunction("call VSCodeNotify('editor.action.marker.next')")
  end, { noremap = true, desc = "open problems diagnostics" })

  map({ "v" }, "<C-c>", function()
    callVSCodeFunction("call VSCodeNotify('editor.action.clipboardCopyAction')")
    print("📎added to clipboard!")
  end, { noremap = true, desc = "copy text/add text to clipboard" })

  map({ "n" }, "<u>", function()
    callVSCodeFunction("call VSCodeNotify('undo')")
  end, { noremap = true, desc = "undo changes" })

  map({ "n" }, "<C-r>", function()
    callVSCodeFunction("call VSCodeNotify('redo')")
  end, { noremap = true, desc = "redo changes" })
end

if vim.g.vscode then  
    print("⚡connected to neovim!💯‼️🤗😎")
    vscodeMappings()
    vim.keymap.set({ "n", "x" }, "<C-u>", function()
        local visibleRanges = require('vscode').eval("return vscode.window.activeTextEditor.visibleRanges")
        local height = visibleRanges[1][2].line - visibleRanges[1][1].line
        for i = 1, height*2/3 do
            vim.api.nvim_feedkeys("k", "n", false)
        end
        require('vscode').action("neovim-ui-indicator.cursorCenter")
    end)
    vim.keymap.set({ "n", "x" }, "<C-d>", function()
        local visibleRanges = require('vscode').eval("return vscode.window.activeTextEditor.visibleRanges")
        local height = visibleRanges[1][2].line - visibleRanges[1][1].line
        for i = 1, height*2/3 do
            vim.api.nvim_feedkeys("j", "n", false)
        end
        require('vscode').action("neovim-ui-indicator.cursorCenter")
    end)
    vim.keymap.set({ "n", "x" }, "<C-f>", function()
        local visibleRanges = require('vscode').eval("return vscode.window.activeTextEditor.visibleRanges")
        local height = visibleRanges[1][2].line - visibleRanges[1][1].line
        for i = 1, height do
            vim.api.nvim_feedkeys("j", "n", false)
        end
        require('vscode').action("neovim-ui-indicator.cursorCenter")
    end)
    vim.keymap.set({ "n", "x" }, "<C-b>", function()
        local visibleRanges = require('vscode').eval("return vscode.window.activeTextEditor.visibleRanges")
        local height = visibleRanges[1][2].line - visibleRanges[1][1].line
        for i = 1, height do
            vim.api.nvim_feedkeys("k", "n", false)
        end
        require('vscode').action("neovim-ui-indicator.cursorCenter")
    end)
else
    vim.keymap.set({ "n", "x" }, "<C-u>", "<C-u>zz")
    vim.keymap.set({ "n", "x" }, "<C-d>", "<C-d>zz")
    vim.keymap.set({ "n", "x" }, "<C-f>", "<C-f>zz")
    vim.keymap.set({ "n", "x" }, "<C-b>", "<C-b>zz")
end
