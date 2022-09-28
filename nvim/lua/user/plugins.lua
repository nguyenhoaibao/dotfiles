local fn = vim.fn

-- Install packer
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(fn.glob(install_path)) > 0 then
  is_bootstrap = true
  fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  vim.cmd [[packadd packer.nvim]]
end

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use {
    'tpope/vim-fugitive',
    branch = 'master'
  }
  use 'tpope/vim-rhubarb'
  use {
      'kyazdani42/nvim-tree.lua',
      requires = {
        'kyazdani42/nvim-web-devicons',
      },
  }
  use 'numToStr/Comment.nvim'
  use 'tpope/vim-surround'
  use 'tpope/vim-cucumber'
  use 'windwp/nvim-autopairs'
  use 'ntpeters/vim-better-whitespace'
  use 'christoomey/vim-tmux-navigator'
  use 'terryma/vim-multiple-cursors'
  use 'sirver/ultisnips'
  use 'ianding1/leetcode.vim'
  use 'nguyenhoaibao/vim-base64'
  use 'dhruvasagar/vim-zoom'
  use 'simrat39/symbols-outline.nvim'
  use 'AndrewRadev/splitjoin.vim'
  -- use 'rust-lang/rust.vim'
  -- use 'simrat39/rust-tools.nvim'
  use 'pangloss/vim-javascript'
  -- use 'leafgarland/typescript-vim'
  use 'tomlion/vim-solidity'
  use {
    'nvim-treesitter/nvim-treesitter',
    -- run = function() require("nvim-treesitter.install").update { with_sync = true } end,
    run = function() pcall(vim.cmd, 'TSUpdate') end,
  }
  use { 'nvim-treesitter/nvim-treesitter-textobjects', requires = { 'nvim-treesitter/nvim-treesitter' } }
  use 'nvim-treesitter/nvim-treesitter-context'

  use {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    requires = {
      'nvim-lua/plenary.nvim',
      -- 'nvim-telescope/telescope-live-grep-raw.nvim',
    },
  }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

  use { 'arcticicestudio/nord-vim', branch = "main" }
  use 'nvim-lualine/lualine.nvim'
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }

  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use 'jose-elias-alvarez/null-ls.nvim'
  use { 'neovim/nvim-lspconfig' }
  use { 'hrsh7th/nvim-cmp', requires = { 'hrsh7th/cmp-nvim-lsp' } }
  use { 'hrsh7th/cmp-vsnip', requires = { 'hrsh7th/nvim-cmp' } }
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'ray-x/lsp_signature.nvim'

  use 'ray-x/go.nvim'
  use 'ray-x/guihua.lua'

  if is_bootstrap then
    require('packer').sync()
  end
end)

if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end

local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | PackerCompile',
  group = packer_group,
  pattern = 'plugins.lua',
})
