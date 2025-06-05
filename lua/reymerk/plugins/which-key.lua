return {
  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    dependencies = {
      { 'tpope/vim-abolish', lazy = false },
    },
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      -- delay between pressing a key and opening which-key (milliseconds)
      -- this setting is independent of vim.o.timeoutlen
      delay = 0,
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },
      -- Document existing key chains
      spec = { },
    },
    config = function(_, opts)
      -- Call the standard setup function with the resolved options
      require('which-key').setup(opts)

      -- Register your custom key mappings for vim-abolish coercions
      require("which-key").add({
        { "cr", group = "coercion" },
        { "crs", desc = "Snake Case" },
        { "cr_", desc = "Snake Case" },
        { "crm", desc = "Mixed Case" },
        { "crc", desc = "Camel Case" },
        { "cru", desc = "Snake Upper Case" },
        { "crU", desc = "Snake Upper Case" },
        { "crk", desc = "Kebab Case" },
        { "crt", desc = "Title Case (not reversible)" },
        { "cr-", desc = "Kebab Case (not reversible)" },
        { "cr.", desc = "Dot Case (not reversible)" },
        { "cr<space>", desc = "Space Case (not reversible)" },
      })
    end,
  },
}
