
if vim.g.vscode then
  -- Scelta del colorscheme
  vim.cmd([[colorscheme default]])

  do
    return
  end
end

require("reymerk.set")
require("reymerk.remap")

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
  -- NOTE: First, some plugins that don't require any configuration

  -- Git related plugins

  -- All the git sweet things inside vim
  'tpope/vim-fugitive',
  -- Add the Hub to the Git
  'tpope/vim-rhubarb',

  'NMAC427/guess-indent.nvim', -- Detect tabstop and shiftwidth automatically

  require "reymerk.plugins.lsp",

  {
   -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',

      -- for copilot
      'zbirenbaum/copilot-cmp'
    },
  },
  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    -- build = "make install_jsregexp"
    config = function()
      require("luasnip.loaders.from_snipmate").load()
      require('luasnip').setup()
    end,
  },

  require "reymerk.plugins.which-key",

  require "reymerk.plugins.gitsigns",

  require "reymerk.plugins.lualine",

  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    main = "ibl",
    opts = {
      -- char = '┊',
      -- show_trailing_blankline_indent = false,
    },
  },

  -- "gc" to comment visual regions/lines
  {
    'numToStr/Comment.nvim',
    opts = {},
    config = function ()
      require('Comment').setup()

      local api = require('Comment.api')

      vim.keymap.set('n', '<C-/>', api.toggle.linewise.current)

      local esc = vim.api.nvim_replace_termcodes(
          '<ESC>', true, false, true
      )
      vim.keymap.set('x', '<C-/>', function()
          vim.api.nvim_feedkeys(esc, 'nx', false)
          api.toggle.linewise(vim.fn.visualmode())
      end)
    end
  },

  require "reymerk.plugins.project",

  require "reymerk.plugins.telescope",

  require "reymerk.plugins.treesitter",

  { import = 'custom.plugins' }
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})


require("reymerk.autocommands")


require("luasnip.loaders.from_snipmate").lazy_load()
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

-- Scelta del colorscheme
-- vim.cmd([[colorscheme monokai-pro]])auto
--
