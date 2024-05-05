-- search settings
vim.opt.smartcase = true
vim.opt.ignorecase = true

vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 2
vim.opt.signcolumn = 'yes'

-- split settings
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.shiftround = true

vim.opt.showmode = false
vim.opt.swapfile = false
vim.opt.undofile = true

-- clipboard
vim.opt.clipboard = 'unnamedplus'

vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

vim.opt.updatetime = 250
vim.opt.timeoutlen = 450

vim.opt.shortmess:append('c')

vim.opt.termguicolors = true
