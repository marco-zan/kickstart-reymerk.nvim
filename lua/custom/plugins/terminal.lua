return {
  'voldikss/vim-floaterm',
  keys = {
    { '<leader>ot', '<cmd>FloatermToggle<cr>', desc = '[O]pen floating [t]erminal', mode='n' },
  },
  config = function ()
    vim.keymap.set('t', "<Esc>", "<C-\\><C-n>:FloatermHide<CR>")
  end

}
