local bind = vim.keymap.set
local opts = { silent = true }

local cmd = vim.api.nvim_create_user_command

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
bind('n', '<Leader>pb', ':Telescope buffers<CR>', opts)
bind('n', '<Leader>pf', function()
  require('telescope.builtin').find_files { hidden = true, previewer = false }
end, opts)
bind('n', '<Leader>/', function()
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, opts)
bind('n', '\\\\', ':Telescope grep_string<CR>', opts)
bind('n', '\\', ':Telescope live_grep<CR>', opts)
bind('n', '<Leader>gy', ':Telescope git_stash<CR>', opts)
bind('n', '<Leader>gb', ':Telescope git_bcommits<CR>', opts)
bind('n', '<Leader>fs', ':Telescope treesitter<CR>', opts)

bind('n', 'ld', ':Telescope diagnostics<CR>', opts)
bind('n', '<Leader>e', vim.diagnostic.open_float, opts)
bind('n', '[d', vim.diagnostic.goto_prev, opts)
bind('n', ']d', vim.diagnostic.goto_next, opts)
