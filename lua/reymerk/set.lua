
-- [[ Setting options ]]
-- See `:help vim.o`

-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set highlight on search and change if i change
vim.o.hlsearch = false
vim.o.incsearch = true

-- Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent - idk be smart
vim.o.breakindent = true
vim.o.smartindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 50
-- vim.o.timeout = true
-- vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- Scroll gives me space to See

vim.opt.scrolloff = 9
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

-- To setu the height of the suggestions (to not shoot all over the place)
vim.opt.pumheight = 8;

-- To choose the best Netrw mode
vim.g.netrw_liststyle=3
-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Automatically open vsplit on the right
vim.opt.splitright = true;

-- About CODE FOLDING

-- Enable code folding 
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

-- To hide the fold column: aka the small arrow on the left
-- vim.opt.foldcolumn = "0"

-- To keep syntax highlighting what?
-- vim.opt.foldtext = "" -- Disabled because is not available on 0.9.X stable relases



-- Setting foldlevel sets the minimum level of a fold that will be closed by default. 
-- Therefore I set this to 99 as I don't want this behaviour at all.
--
-- However, I discovered that I can use foldlevelstart to dicate upon editing a buffer
-- what level of folds should be open by default vs closed.
--
-- After some experimenting, I settled on 1 for this value, meaning top level folds are
-- open, but anything nested beyond that is closed. I've found this helps with navigating
-- a large file as not all the contents will be expanded initially.
vim.opt.foldlevel = 99
vim.opt.foldleveldstart = 1

-- This limits how deeply code gets folded, and I've found that I don't really care for
-- nesting some object 20 levels deep into a function (however rare that is!). So I set
-- this value to 4, meaning that once code gets beyond 4 levels it won't be broken down
-- into more granular folds. I've found this means I can easily toggle larger chunks of
-- nested code as they are treated as one fold. 
-- I think this a very subjective setting though!
vim.opt.foldnestmax = 4
