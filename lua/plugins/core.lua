-- =========================================================
-- Core / Utility Plugins
-- =========================================================

return {

  -- Detect tabstop and shiftwidth automatically
  {
    "tpope/vim-sleuth",
  },

  -- Smooth scrolling
  {
    "karb94/neoscroll.nvim",
    opts = {},
  },

  -- Surround text objects (ys, ds, cs)
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end,
  },

  -- Auto-close brackets, quotes, etc.
  {
    "m4xshen/autoclose.nvim",
    config = function()
      require("autoclose").setup()
    end,
  },

  -- Mini.nvim collection (ai, surround, statusline)
  {
    "echasnovski/mini.nvim",
    config = function()
      -- Better around/inside textobjects
      require("mini.ai").setup({ n_lines = 500 })

      -- Add/delete/replace surroundings
      require("mini.surround").setup()

      -- Minimal statusline
      local statusline = require("mini.statusline")
      statusline.setup({ use_icons = vim.g.have_nerd_font })

      -- Custom cursor location format
      statusline.section_location = function()
        return "%2l:%-2v"
      end
    end,
  },
}
