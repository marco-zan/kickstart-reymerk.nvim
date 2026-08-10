return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    config = function()
      require('nvim-treesitter').install {
        'bash',
        'c',
        'diff',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'php',
        'python',
      }
    end,

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
