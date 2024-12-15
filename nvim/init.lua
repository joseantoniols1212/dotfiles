require("config.lazy")

-- Keymaps config

-- leader key
vim.g.mapleader = ' '

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- optionally enable 24-bit colour
vim.opt.termguicolors = true
-- system clipboard
vim.opt.clipboard = 'unnamedplus'

-- General
vim.keymap.set('n', '<leader>xb', ':w<CR>:bd<CR>', { desc = 'Save and close buffer' })
vim.keymap.set('n', '<C-L>', '<C-W>l', { desc = 'Move to right pane' })
vim.keymap.set('n', '<C-J>', '<C-W>j', { desc = 'Move to down pane' })
vim.keymap.set('n', '<C-H>', '<C-W>h', { desc = 'Move to left pane' })
vim.keymap.set('n', '<C-K>', '<C-W>k', { desc = 'Move to up pane' })


-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- Nvimtree
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = 'Toggle file tree' })
vim.keymap.set('n', '<leader>n', ':bnext<CR>', { desc = 'Next buffer' })
