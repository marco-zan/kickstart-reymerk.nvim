
if vim.g.vscode then
  -- Scelta del colorscheme
  vim.cmd([[colorscheme default]])

  do
    return
  end
end

require("reymerk.set")

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

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      -- Mason must be loaded before its dependents so we need to set it up here.
      -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      { 'j-hui/fidget.nvim', opts = {} },

      -- Allows extra capabilities provided by blink.cmp
      'saghen/blink.cmp',

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
      'kevinhwang91/promise-async',
      "kevinhwang91/nvim-ufo",
    },
  },

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

  require "reymerk.plugins.telescope",

  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'windwp/nvim-ts-autotag'
    },
    config = function()
      if pcall(require('nvim-treesitter.install').update { with_sync = true }) then
        require('nvim-ts-autotag').setup({
          opts = {
            -- Defaults
            enable_close = true, -- Auto close tags
            enable_rename = true, -- Auto rename pairs of tags
            enable_close_on_slash = false -- Auto close on trailing </
          },
          aliases = {
            ["htmldjango"] = "html",
          }
        })
      end
    end,
  },

  require "reymerk.plugins.treesitter",

  -- To highlight the color in css files. It is sooooo handy
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup {
        css = { rgb_fn = true; hsl_fn = true; names = true; RGB = true; RRGGBB = true;};
        scss ={ rgb_fn = true; hsl_fn = true; names = true; RGB = true; RRGGBB = true;};
        sass = { rgb_fn = true; hsl_fn = true; names = true; RGB = true; RRGGBB = true;};
        html = { rgb_fn = true; hsl_fn = true; names = true; RGB = true; RRGGBB = true;};
        htmldjango = { rgb_fn = true; hsl_fn = true; names = true; RGB = true; RRGGBB = true;};
        'javascript';
        'javascriptreact';
        'typescript';
        'typescriptreact';
        'vue';
        'svelte';
        'lua';
      }
    end,

  },

  {
    url = 'https://tpope.io/vim/abolish.git',
  },
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup {}
    end,

  },

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
require('reymerk.lsp')
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

-- Scelta del colorscheme
-- vim.cmd([[colorscheme monokai-pro]])auto
--
require("reymerk.remap")
