
if vim.g.neovide then
  vim.o.guifont = "CaskaydiaCove NFM:h12"
  vim.g.neovide_normal_opacity = 0.8

  vim.g.neovide_scroll_animation_length = 0.1
  vim.g.neovide_scroll_animation_far_lines = 0

  vim.g.neovide_hide_mouse_when_typing = true

  vim.g.neovide_cursor_animate_in_insert_mode = false
  vim.g.neovide_cursor_trail_size = 0.2
  vim.g.neovide_cursor_animation_length = 0.08


  -- [[ GUI Keymaps ]]
  vim.keymap.set('n', '<M-t>', function ()
    vim.cmd("tabnew|terminal /usr/bin/env fish")
  end, { desc = "[D]iagnostics [D]iagnostics cursor position" })

  for i = 1, 9 do
    vim.keymap.set(
      {"n", "t"},
      "<M-" .. i.. ">",
      "<Cmd>tabn " .. i .. "<CR>",
      {
        desc = "Switch to tab " .. i,
        noremap = true,
        silent = true,
      }
    )
  end

  -- Move the current tab
  -- ghostty: alt+period=move_tab:-1
  vim.keymap.set(
    'n',
    '<M-.>',
    '<Cmd>tabmove -1<CR>',
    { desc = 'Move tab left', silent = true }
  )
  -- ghostty: alt+comma=move_tab:+1
  vim.keymap.set(
    'n',
    '<M-,>',
    '<Cmd>tabmove +1<CR>',
    { desc = 'Move tab right', silent = true }
  )

  -- Split (Window) Management
  ----------------------------

  -- Create new terminal splits
  -- ghostty: alt+p=new_split:right
  vim.keymap.set('n', '<M-p>', function()
    vim.cmd('vsplit | terminal')
  end, { desc = 'New terminal split right' })
  -- ghostty: alt+shift+p=new_split:left
  vim.keymap.set('n', '<M-S-p>', function()
    vim.cmd('leftabove vsplit | terminal')
  end, { desc = 'New terminal split left' })
  -- ghostty: alt+-=new_split:down
  vim.keymap.set('n', '<M- ->', function()
    vim.cmd('split | terminal')
  end, { desc = 'New terminal split down' })

  -- Navigate between splits
  -- ghostty: alt+l=goto_split:right
  vim.keymap.set(
    'n',
    '<M-l>',
    '<C-w>l',
    { desc = 'Go to split right', silent = true }
  )
  -- ghostty: alt+h=goto_split:left
  vim.keymap.set(
    'n',
    '<M-h>',
    '<C-w>h',
    { desc = 'Go to split left', silent = true }
  )
  -- ghostty: alt+j=goto_split:bottom
  vim.keymap.set(
    'n',
    '<M-j>',
    '<C-w>j',
    { desc = 'Go to split down', silent = true }
  )
  -- ghostty: alt+k=goto_split:top
  vim.keymap.set(
    'n',
    '<M-k>',
    '<C-w>k',
    { desc = 'Go to split up', silent = true }
  )
end
