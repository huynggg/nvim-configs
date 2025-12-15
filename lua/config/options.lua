-- =========================================================
-- Options
-- =========================================================

-- Leader keys (must be set before plugins)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Nerd Font flag
vim.g.have_nerd_font = true

-- ---------------------------------------------------------
-- Editor behavior
-- ---------------------------------------------------------
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.breakindent = true
vim.opt.undofile = true

-- ---------------------------------------------------------
-- Searching
-- ---------------------------------------------------------
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- ---------------------------------------------------------
-- UI
-- ---------------------------------------------------------
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.scrolloff = 10

-- ---------------------------------------------------------
-- Performance
-- ---------------------------------------------------------
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- ---------------------------------------------------------
-- Splits
-- ---------------------------------------------------------
vim.opt.splitright = true
vim.opt.splitbelow = true

-- ---------------------------------------------------------
-- Whitespace
-- ---------------------------------------------------------
vim.opt.list = true
vim.opt.listchars = {
  tab = "» ",
  trail = "·",
  nbsp = "␣",
}

-- ---------------------------------------------------------
-- Command preview
-- ---------------------------------------------------------
vim.opt.inccommand = "split"

-- ---------------------------------------------------------
-- Clipboard (deferred to reduce startup time)
-- ---------------------------------------------------------
vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)
