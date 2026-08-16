
-- 80-column guide and wrap width for markdown (matches pre-commit markdownlint MD013)
vim.api.nvim_create_autocmd('FileType', {
  desc = '80-column colorcolumn and textwidth for markdown',
  pattern = 'markdown',
  callback = function()
    vim.wo.colorcolumn = '80'
    vim.bo.textwidth = 80
  end,
})

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})
