-- =========================================================
-- Formatting
-- =========================================================

return {

  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>f",
        function()
          require("conform").format({
            async = true,
            lsp_format = "fallback",
          })
        end,
        desc = "[F]ormat buffer",
      },
    },
    opts = {
      notify_on_error = false,

      format_on_save = function(bufnr)
        local disable_filetypes = {
          c = true,
          cpp = true,
        }

        local lsp_format
        if disable_filetypes[vim.bo[bufnr].filetype] then
          lsp_format = "never"
        else
          lsp_format = "fallback"
        end

        return {
          timeout_ms = 500,
          lsp_format = lsp_format,
        }
      end,

      formatters_by_ft = {
        lua = { "stylua" },
        bash = { "shfmt" },
        -- python = { "isort", "black" },
      },
    },
  },
}
