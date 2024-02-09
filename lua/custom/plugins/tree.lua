return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()

    local HEIGHT_RATIO = 0.8 -- You can change this
    local WIDTH_RATIO = 0.5  -- You can change this too

    local function my_on_attach(bufnr)
      local api = require "nvim-tree.api"

      local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      -- default mappings
      -- api.config.mappings.default_on_attach(bufnr)

      -- custom mappings
      vim.keymap.set('n', 'c', api.fs.create,        opts('Create file or dir'))
      vim.keymap.set('n', 'y', api.fs.copy.node,        opts('Yank file'))
      vim.keymap.set('n', 'm', api.marks.toggle,        opts('Toggle mark'))
      vim.keymap.set('n', 'bm', api.marks.bulk.move,        opts('Move selected'))

      vim.keymap.set('n', 'p', api.fs.paste,        opts('Paste file'))
      vim.keymap.set('n', '<CR>', api.node.open.edit,        opts('Open'))

      vim.keymap.set('n', 'r', api.fs.rename,        opts('Rename'))
      vim.keymap.set('n', 'x', api.fs.trash,        opts('Delete'))

      vim.keymap.set('n', 'q', api.tree.close,        opts('Close nvimTree'))
      -- vim.keymap.set('n', '?',     api.tree.toggle_help,                  opts('Help'))
    end

    require("nvim-tree").setup {
      on_attach = my_on_attach,
      disable_netrw = true,
      hijack_netrw = true,
      respect_buf_cwd = true,
      sync_root_with_cwd = true,
      view = {
        relativenumber = true,
        float = {
          enable = true,
          open_win_config = function()
            local screen_w = vim.opt.columns:get()
            local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
            local window_w = screen_w * WIDTH_RATIO
            local window_h = screen_h * HEIGHT_RATIO
            local window_w_int = math.floor(window_w)
            local window_h_int = math.floor(window_h)
            local center_x = (screen_w - window_w) / 2
            local center_y = ((vim.opt.lines:get() - window_h) / 2)
            - vim.opt.cmdheight:get()
            return {
              border = "rounded",
              relative = "editor",
              row = center_y,
              col = center_x,
              width = window_w_int,
              height = window_h_int,
            }
          end,
        },
        width = function()
          return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
        end,
      },
      -- filters = {
      --   custom = { "^.git$" },
      -- },
      -- renderer = {
      --   indent_width = 1,
      -- },
    }
  end,
}
