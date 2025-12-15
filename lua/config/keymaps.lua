-- =========================================================
-- Keymaps
-- =========================================================

local map = vim.keymap.set

-- ---------------------------------------------------------
-- General
-- ---------------------------------------------------------

-- Clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostics
map("n", "<leader>q", vim.diagnostic.setloclist, {
  desc = "Open diagnostic quickfix list",
})

-- ---------------------------------------------------------
-- Window navigation
-- ---------------------------------------------------------
map("n", "<C-h>", "<C-w><C-h>", { desc = "Move to left window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move to right window" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move to lower window" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move to upper window" })

-- ---------------------------------------------------------
-- Terminal
-- ---------------------------------------------------------
map("t", "<Esc><Esc>", "<C-\\><C-n>", {
  desc = "Exit terminal mode",
})

-- ---------------------------------------------------------
-- Git (quick commit)
-- ---------------------------------------------------------
map("n", "<leader>gc", function()
  vim.fn.system("git add -A && git commit -m 'Updated'")
end, { desc = "Quick Git Commit" })
