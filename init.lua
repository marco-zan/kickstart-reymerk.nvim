
if vim.g.vscode then
  -- Scelta del colorscheme
  vim.cmd([[colorscheme default]])
end

require("reymerk.settings_neovide")
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

  -- Git related plugins
  -- All the git sweet things inside vim
  'tpope/vim-fugitive',
  -- Add the Hub to the Git
  'tpope/vim-rhubarb',

  'NMAC427/guess-indent.nvim', -- Detect tabstop and shiftwidth automatically

  require "reymerk.plugins.cosobrutto",

  require "reymerk.plugins.bruttissimo-autocomplete",

  require "reymerk.plugins.which-key",

  require "reymerk.plugins.gitsigns",

  require "reymerk.plugins.lualine",

  -- I don't even know what it does and wether i need it
  --
  -- { -- Add indentation guides even on blank lines
  --   'lukas-reineke/indent-blankline.nvim',
  --   -- Enable `lukas-reineke/indent-blankline.nvim`
  --   -- See `:help indent_blankline.txt`
  --   main = "ibl",
  --   opts = {
  --     -- char = '┊',
  --     -- show_trailing_blankline_indent = false,
  --   },
  -- },

  -- "gc" to comment visual regions/lines
  require "reymerk.plugins.supercomment",

  require "reymerk.plugins.project",

  require "reymerk.plugins.telescope",

  require "reymerk.plugins.treesitter",

  require "reymerk.plugins.verymini",

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

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
