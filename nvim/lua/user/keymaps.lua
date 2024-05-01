local bind = vim.keymap.set
local opts = { silent = true }

local cmd = vim.api.nvim_create_user_command
local tls_builtin = require('telescope.builtin')

bind({ 'n', 'v' }, '<Space>', '<Nop>')
vim.g.mapleader = ' '

bind('n', '<Leader>w', ':w<CR>', opts)
bind('n', '<Leader>nh', ':noh<CR><c-l>', opts)
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

-- nvim-tree
bind('n', '<Leader>d', ':NvimTreeToggle<CR>', opts)
bind('n', 'F', ':NvimTreeFindFileToggle<CR>', opts)

-- telescope
bind('n', '<Leader>pb', tls_builtin.buffers, opts)
bind('n', '<Leader>pf', function()
  tls_builtin.find_files { hidden = true, previewer = false }
end, opts)
bind('n', '<Leader>/', function()
  tls_builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, opts)
bind('n', '\\\\', tls_builtin.grep_string, opts)
bind('n', '\\', tls_builtin.live_grep, opts)
bind('n', '<Leader>gy', tls_builtin.git_stash, opts)
bind('n', '<Leader>gb', tls_builtin.git_bcommits, opts)
vim.api.nvim_set_keymap('v', '<Leader>gbr', '<cmd>lua require("telescope.builtin").git_bcommits_range()<CR>',
  { noremap = true, silent = true })
bind('n', '<Leader>fs', tls_builtin.git_branches, opts)

-- bind('n', 'ld', tls_builtin.diagnostics, opts)
bind('n', '<Leader>e', vim.diagnostic.open_float, opts)
bind('n', '[d', vim.diagnostic.goto_prev, opts)
bind('n', ']d', vim.diagnostic.goto_next, opts)
