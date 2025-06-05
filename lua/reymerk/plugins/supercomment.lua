return {
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
}
