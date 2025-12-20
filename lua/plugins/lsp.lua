-- =========================================================
-- LSP Configuration
-- =========================================================

return {

  -- Lua development helpers (Neovim runtime + plugins)
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },

  { "Bilal2453/luvit-meta", lazy = true },

  -- -------------------------------------------------------
  -- Main LSP setup
  -- -------------------------------------------------------
  {
    "neovim/nvim-lspconfig",
    dependencies = {

      -- LSP installer
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",

      -- Status updates
      { "j-hui/fidget.nvim", opts = {} },

      -- Completion capabilities
      "hrsh7th/cmp-nvim-lsp",
    },

    config = function()
      -- ---------------------------------------------------
      -- LSP attach behavior
      -- ---------------------------------------------------
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, {
              buffer = event.buf,
              desc = "LSP: " .. desc,
            })
          end

          -- Navigation
          map("gd", require("telescope.builtin").lsp_definitions, "Goto Definition")
          map("gr", require("telescope.builtin").lsp_references, "Goto References")
          map("gI", require("telescope.builtin").lsp_implementations, "Goto Implementation")
          map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type Definition")

          -- Symbols
          map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "Document Symbols")
          map("<leader>ws", require("telescope.builtin").lsp_workspace_symbols, "Workspace Symbols")

          -- Actions
          map("<leader>rn", vim.lsp.buf.rename, "Rename")
          map("<leader>ca", vim.lsp.buf.code_action, "Code Action", { "n", "x" })
          map("gD", vim.lsp.buf.declaration, "Goto Declaration")

          -- -------------------------------------------------
          -- Document highlight
          -- -------------------------------------------------
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method("textDocument/documentHighlight") then
            local hl_group = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })

            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = event.buf,
              group = hl_group,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = event.buf,
              group = hl_group,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd("LspDetach", {
              buffer = event.buf,
              callback = function()
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({
                  group = "lsp-highlight",
                  buffer = event.buf,
                })
              end,
            })
          end

          -- -------------------------------------------------
          -- Inlay hints toggle
          -- -------------------------------------------------
          if client and client.supports_method("textDocument/inlayHint") then
            map("<leader>th", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
            end, "Toggle Inlay Hints")
          end
        end,
      })

      -- ---------------------------------------------------
      -- Capabilities (nvim-cmp)
      -- ---------------------------------------------------
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

      -- ---------------------------------------------------
      -- Servers
      -- ---------------------------------------------------
      local servers = {

        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        },

        -- pylsp = {
        --   settings = {
        --     pylsp = {
        --       plugins = {
        --         pycodestyle = {
        --           ignore = { "E501", "E402" },
        --         },
        --       },
        --     },
        --   },
        -- },
      }

      -- ---------------------------------------------------
      -- Mason
      -- ---------------------------------------------------
      require("mason").setup()

      local ensure_installed = vim.tbl_keys(servers)
      vim.list_extend(ensure_installed, {
        -- YAML
        "yamlls",

        -- SQL
        "sqlls",

        -- Web
        "tailwindcss",
        "cssls",
        "html",
        "ts_ls",

        -- Python
        -- "pylsp",
        "djlsp",
        "ruff",

        -- Shell
        "bashls",

        -- Beancount
        "beancount",

        -- C / C++
        "clangd",

        -- Go
        "gopls",

        -- Templates
        "jinja_lsp",

        -- Lua
        "lua_ls",

        -- Markdown
        "marksman",

        -- Formatters
        "black",
        "clang-format",
        "shfmt",
        "stylua",
      })

      require("mason-tool-installer").setup({
        ensure_installed = ensure_installed,
      })

      require("mason-lspconfig").setup({
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            require("lspconfig")[server_name].setup(server)
          end,
        },
      })
    end,
  },
}
