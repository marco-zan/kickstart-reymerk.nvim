return {
  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },

    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      local actions = require('telescope.actions')
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        -- This strategy adapts well the telescope window even for small
        -- windows (without needing to resize)
        defaults = {
          layout_strategy = 'flex',
          layout_config = {
            flex = {
              flip_columns = 160,
            },
            horizontal = {
              preview_width = 0.5,
              width = 0.85,
              height = 0.85
            },
            vertical = {
              prompt_position = 'bottom',
              preview_cutoff = 10,
              preview_height = 0.5,
              height = 0.95
            }
          },
          mappings = {
            i = {
              ['<esc>'] = {
                actions.close, type = 'action'
              },
              ['<C-p>'] = actions.cycle_history_prev,
              ['<C-n>'] = actions.cycle_history_prev,
              ["<C-j>"] = {
                actions.move_selection_next, type = "action",
                opts = { nowait = true, silent = true }
              },
              ["<C-k>"] = {
                actions.move_selection_previous, type = "action",
                opts = { nowait = true, silent = true }
              },
            },
          },
        },
        -- pickers = {}
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- The real magic: automatically identify the project root based on git files or
      -- lsp active in the current buffer
      function PROJECT_ROOT()
        -- This works because I have another plugin that dynamically changes
        -- the working directory based on the project root (using lsp, git and
        -- other things)
        return vim.loop.cwd()
      end

      -- Enable telescope fzf native, if installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- See `:help telescope.builtin`
      local builtin = require('telescope.builtin')
      -- vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })

      vim.keymap.set('n', '<leader><space>',
        function ()
          local opts = {}
          opts.cwd = PROJECT_ROOT()
          builtin.find_files(opts)
        end, { desc = 'Project find files' })

      vim.keymap.set('n', '<leader>/',
        function ()
          local opts = {}
          opts.cwd = PROJECT_ROOT()
          builtin.live_grep( opts )
        end, { desc = '[/] Grep search in current project' })

      vim.keymap.set('n', '<leader>hh', builtin.help_tags, { desc = '[H]elp' })
      vim.keymap.set('n', '<leader>bb', builtin.buffers, { desc = '[B]uffers [B]uffers list' })

      vim.keymap.set('n', '<leader>db',
        function ()
          local opts = {}
          opts.root_dir = PROJECT_ROOT()
          opts.bufnr = 0 -- Current buffer
          builtin.diagnostics( opts )
        end, { desc = '[D]iagnostics [B]uffer ' })

      vim.keymap.set('n', '<leader>deb',
        function ()
          local opts = {}
          opts.root_dir = PROJECT_ROOT()
          opts.bufnr = 0 -- Current buffer
          opts.severity_limit = "error"
          builtin.diagnostics( opts )
        end, { desc = '[D]iagnostics [E]rrors [B]uffer ' })

      vim.keymap.set('n', '<leader>dp',
        function ()
          local opts = {}
          opts.root_dir = PROJECT_ROOT()
          opts.bufnr = nil -- All buffers
          builtin.diagnostics( opts )
        end, { desc = '[D]iagnostics [P]roject ' })

      vim.keymap.set('n', '<leader>dep',
        function ()
          local opts = {}
          opts.root_dir = PROJECT_ROOT()
          opts.bufnr = nil -- All buffers
          opts.severity_limit = "error"
          builtin.diagnostics( opts )
        end, { desc = '[D]iagnostics [E]rrors [P]roject ' })

    end
  },
}

