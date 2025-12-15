-- =========================================================
-- Treesitter
-- =========================================================

return {

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    main = "nvim-treesitter.configs",
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "diff",
        "html",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "query",
        "vim",
        "vimdoc",
      },

      -- Automatically install missing parsers
      auto_install = true,

      highlight = {
        enable = true,

        -- Some languages (e.g. Ruby) rely on Vim regex highlighting for indentation
        additional_vim_regex_highlighting = { "ruby" },
      },

      indent = {
        enable = true,
        disable = { "ruby" },
      },
    },
  },

  -- -------------------------------------------------------
  -- TreeSJ (split / join code structures)
  -- -------------------------------------------------------
  {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    keys = {
      { "<space>m", desc = "TreeSJ toggle" },
      { "<space>j", desc = "TreeSJ join" },
      { "<space>s", desc = "TreeSJ split" },
    },
    config = function()
      require("treesj").setup({})
    end,
  },
}
