return {
-- TODO: Fix that this do not highlight until :TSEnable highlight
  -- maybe due to lsp failure to start (jinja-lsp)
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      -- Add languages to be installed here that you want installed for treesitter
      ensure_installed = {
        'bash',
        'c',
        'diff',
        'html',
        -- 'htmldjango'
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'python',
        'query',
        -- 'tsx',
        -- 'typescript',
        'vim',
        'vimdoc',
        -- 'zig',
      },

      -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
      auto_install = true,

      highlight = { enable = true },
      indent = { enable = true },
      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ['aa'] = '@parameter.outer',
            ['ia'] = '@parameter.inner',
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
          },
        },
      },
    },
    dependencies = {
      {
        'nvim-treesitter/nvim-treesitter-context',
        opts = {

          enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
          max_lines = 4, -- How many lines the window should span. Values <= 0 mean no limit.
          trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
          min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
          line_numbers = true,
          mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
          -- Separator between context and content. Should be a single character string, like '-'.
          zindex = 20, -- The Z-index of the context window
        },
      },
    },
  },
}
