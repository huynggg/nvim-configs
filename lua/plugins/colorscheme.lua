-- =========================================================
-- Colorscheme
-- =========================================================

return {

  {
    "EdenEast/nightfox.nvim",
    priority = 1000, -- Load before UI plugins
    config = function()
      -- Apply colorscheme
      vim.cmd.colorscheme("nightfox")

      -- Match previous behavior
      vim.cmd.hi("Comment gui=none")
    end,
  },
}
