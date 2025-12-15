-- =========================================================
-- Completion / Snippets
-- =========================================================

return {

  -- -------------------------------------------------------
  -- Snippets
  -- -------------------------------------------------------
  {
    "L3MON4D3/LuaSnip",
    build = (function()
      if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
        return
      end
      return "make install_jsregexp"
    end)(),
    config = function()
      require("luasnip").config.setup({})
    end,
  },

  -- -------------------------------------------------------
  -- nvim-cmp
  -- -------------------------------------------------------
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "folke/lazydev.nvim",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-y>"] = cmp.mapping.confirm({ select = true }),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-l>"] = cmp.mapping(function()
            if luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { "i", "s" }),
          ["<C-h>"] = cmp.mapping(function()
            if luasnip.jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { "i", "s" }),
        }),
        sources = {
          {
            name = "lazydev",
            group_index = 0,
          },
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
          { name = "buffer" },
        },
      })

      -- Beancount: only buffer completion
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "beancount",
        callback = function()
          cmp.setup.buffer({
            sources = {
              { name = "buffer" },
            },
          })
        end,
      })
    end,
  },

  -- -------------------------------------------------------
  -- Tabout (jump out of pairs)
  -- -------------------------------------------------------
  {
    "abecodes/tabout.nvim",
    event = "InsertCharPre",
    priority = 1000,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "L3MON4D3/LuaSnip",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("tabout").setup({
        tabkey = "<Tab>",
        backwards_tabkey = "<S-Tab>",
        act_as_tab = true,
        enable_backwards = true,
        completion = false,
        tabouts = {
          { open = "'", close = "'" },
          { open = '"', close = '"' },
          { open = "`", close = "`" },
          { open = "(", close = ")" },
          { open = "[", close = "]" },
          { open = "{", close = "}" },
        },
        ignore_beginning = true,
      })
    end,
  },
}
