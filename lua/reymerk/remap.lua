
-- Easy save file -- and... you know, why not have both
vim.keymap.set('n', '<C-s>', function() vim.cmd('up') end, { desc = '[S] Save buffer' })
vim.keymap.set('n', '<leader>s', function() vim.cmd('up') end, { desc = '[S] Save buffer' })

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>dd', vim.diagnostic.open_float, { desc = "[D]iagnostics [D]iagnostics cursor position" })
-- This is just as a fallback, if telescope is not working (please no)
vim.keymap.set('n', '<leader>db', vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- buffer navigation

vim.keymap.set('n', '<leader>bt', function() vim.cmd('e ~/vim_temp.txt') end, { desc = '[B]uffer [T]emporary' })


-- To move the code with shift J and K
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- To keep selection when indenting
vim.keymap.set("v", "<", "<gv", { noremap = true })
vim.keymap.set("v", ">", ">gv", { noremap = true })

-- Shift-J the right way
vim.keymap.set("n", "J", "mzJ`z")

-- Improved search to make searched text always on the center
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever - paste without losing what you are pasting
-- gonna love it
vim.keymap.set("x", "<leader>p", [["_dP]])

-- worst place in the universe 
vim.keymap.set("n", "Q", "<nop>")

-- Replace under cursor
vim.keymap.set("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- To open full-page terminal -- no plugins neede
vim.keymap.set('n', '<leader>oT', function() vim.api.nvim_command('terminal') end, { desc = '[O]pen Full-page [T]erminal' })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.api.nvim_set_keymap(
    "n",
    "<leader>op",
    ":NvimTreeFindFile<CR>",
    {
        noremap = true,
        desc = "[O]pen [P]roject dir"
    }

)

-- 
vim.keymap.set('n', '<leader>fp', 'vi"p', { desc = 'Paste into double hypens' })

-- Fugitive maps 
vim.keymap.set('n', '<leader>gm', function() vim.cmd('Gvdiffsplit') end, { desc = '[G]it show [M]odifications (diff)' })
vim.keymap.set('n', '<leader>gd', function() vim.cmd('Gvdiffsplit') end, { desc = '[G]it show [D]iff' })
vim.keymap.set('n', '<leader>gg', function() vim.cmd('G') end, { desc = '[G]it [G]it status' })
vim.keymap.set('n', '<leader>gcc', function() vim.cmd('G commit') end, { desc = '[G]it [C]ommit [C]ode' })
vim.keymap.set('n', '<leader>gb', function() vim.cmd('GBrowse') end, { desc = '[G]it show in [B]rowser' })
