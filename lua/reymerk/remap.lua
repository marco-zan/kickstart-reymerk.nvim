
-- Easy save file
vim.keymap.set('n', '<C-s>', function() vim.cmd('up') end, { desc = '[S] Save buffer' })

-- buffer navigation

vim.keymap.set('n', '<leader>b]', function() vim.cmd('bn') end, { desc = '[bn] Next buffer' })
vim.keymap.set('n', '<leader>]', function() vim.cmd('bn') end, { desc = '[bn] Next buffer' })
vim.keymap.set('n', '<leader>bn', function() vim.cmd('bn') end, { desc = '[bn] Next buffer' })

vim.keymap.set('n', '<leader>b[', function() vim.cmd('bp') end, { desc = '[bp] Previous buffer' })
vim.keymap.set('n', '<leader>[', function() vim.cmd('bp') end, { desc = '[bp] Previous buffer' })
vim.keymap.set('n', '<leader>bp', function() vim.cmd('bp') end, { desc = '[bp] Previous buffer' })

vim.keymap.set('n', '<leader>bd', function() vim.cmd('bd') end, { desc = '[bd] Buffer delete' })

vim.keymap.set('n', '<leader>bt', function() vim.cmd('e ~/vim_temp.txt') end, { desc = '[bt] Temporary Buffer' })

-- Harpoon keymaps
-- vim.keymap.set('n', '<leader>bh', require("harpoon.ui").toggle_quick_menu, { desc = "[B]uffers list [H]arpoon" })
-- vim.keymap.set('n', '<leader>hl', require("harpoon.ui").toggle_quick_menu, { desc = "[H]arpoon [L]ist" })
--
-- vim.keymap.set('n', '<leader>hm', require("harpoon.mark").add_file, { desc = "[H]arpoon [M]ark" })
--
-- vim.keymap.set('n', '<leader>h]', require("harpoon.ui").nav_next, { desc = '[->] Next buffer' })
-- vim.keymap.set('n', '<leader>h[', require("harpoon.ui").nav_prev, { desc = '[<-] Previous buffer' })

-- To move the code with shift J and K
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

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
