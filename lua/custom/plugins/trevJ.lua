return {
  'AckslD/nvim-trevJ.lua',
  keys = {
    {'fa', nil, desc = '[F]ormat [A]rgs', mode ='n'},
  },
  config = function (opts)
    local trevj = require('trevj')
    trevj.setup(opts)
    vim.keymap.set('n', 'fa', trevj.format_at_cursor, { desc = '[F]ormat [A]rgs' })
  end
}
