vim.g.mapleader = ' '

local bind = vim.keymap.set
local opts = { silent = true }

local cmd = vim.api.nvim_create_user_command

bind({ 'n', 'v' }, '<Space>', '<Nop>')

bind('n', '<Leader>w', ':w<CR>', opts)
bind('n', '<Leader>nh', ':nohl<CR>', { desc = 'Clear search highlights', silent = true })
bind('n', '<Leader>a', ':keepjumps normal! ggVG<CR>', opts)
bind('n', '[b', ':bprevious<CR>', opts)
bind('n', ']b', ':bnext<CR>', opts)
bind('n', ']q', ':cnext<CR>', opts)
bind('n', '[q', ':cprevious<CR>', opts)

bind("v", "<A-j>", ":m .+1<CR>==", opts)
bind("v", "<A-k>", ":m .-2<CR>==", opts)

cmd('W', 'w', { bang = true })
cmd('Q', 'qa!', { bang = true })
cmd('Qa', 'qa!', { bang = true })

-- vim-fugitive
bind('n', '<Leader>gt', ':Git commit -v -q %:p<CR>', opts)
