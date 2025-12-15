-- =========================================================
-- UI / UX Plugins
-- =========================================================

return {

  -- Which-key: show pending keybindings
  {
    "folke/which-key.nvim",
    event = "VimEnter",
    opts = {
      icons = {
        mappings = vim.g.have_nerd_font,
        keys = vim.g.have_nerd_font and {} or {
          Up = "<Up> ",
          Down = "<Down> ",
          Left = "<Left> ",
          Right = "<Right> ",
          C = "<C-…> ",
          M = "<M-…> ",
          D = "<D-…> ",
          S = "<S-…> ",
          CR = "<CR> ",
          Esc = "<Esc> ",
          Space = "<Space> ",
          Tab = "<Tab> ",
          F1 = "<F1>",
          F2 = "<F2>",
          F3 = "<F3>",
          F4 = "<F4>",
          F5 = "<F5>",
          F6 = "<F6>",
          F7 = "<F7>",
          F8 = "<F8>",
          F9 = "<F9>",
          F10 = "<F10>",
          F11 = "<F11>",
          F12 = "<F12>",
        },
      },
      spec = {
        { "<leader>c", group = "[C]ode", mode = { "n", "x" } },
        { "<leader>d", group = "[D]ocument" },
        { "<leader>r", group = "[R]ename" },
        { "<leader>s", group = "[S]earch" },
        { "<leader>w", group = "[W]orkspace" },
        { "<leader>t", group = "[T]oggle" },
        { "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
      },
    },
  },

  -- Toggle floating terminal
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    cmd = "ToggleTerm",
    keys = {
      { "<F3>", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
      { "<leader>tt", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
    },
    opts = {
      open_mapping = [[<F3>]],
      direction = "float",
    },
  },

  -- Diagnostics / lists UI
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {},
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer diagnostics" },
      { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols" },
      { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP list" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location list" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix list" },
    },
  },

  -- Distraction-free mode
  {
    "folke/zen-mode.nvim",
    keys = {
      {
        "<leader>z",
        function()
          require("zen-mode").toggle()
        end,
        desc = "Toggle Zen Mode",
      },
    },
    opts = {},
  },

  -- Floating TODO list
  {
    "vimichael/floatingtodo.nvim",
    config = function()
      require("floatingtodo").setup({
        target_file = "~/notes/todo.md",
        width = 0.9,
        position = "center",
      })
      vim.keymap.set("n", "<leader>td", ":Td<CR>", { silent = true })
    end,
  },

  -- Cursor trail effect
  {
    "sphamba/smear-cursor.nvim",
    opts = {
      stiffness = 0.5,
      trailing_stiffness = 0.5,
      damping = 0.67,
      matrix_pixel_threshold = 0.5,
    },
  },
}
