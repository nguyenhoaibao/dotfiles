-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.cmd [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]]

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use {
    'tpope/vim-fugitive',
    branch = 'master'
  }
  use 'tpope/vim-rhubarb'
  use 'ray-x/lsp_signature.nvim'
  use {
      'kyazdani42/nvim-tree.lua',
      requires = {
        'kyazdani42/nvim-web-devicons',
      },
  }
  use 'scrooloose/nerdcommenter'
  use 'tpope/vim-surround'
  use 'tpope/vim-cucumber'
  use 'jiangmiao/auto-pairs'
  use 'ntpeters/vim-better-whitespace'
  use 'christoomey/vim-tmux-navigator'
  use 'terryma/vim-multiple-cursors'
  use 'sirver/ultisnips'
  use 'ianding1/leetcode.vim'
  use 'hashivim/vim-terraform'
  use 'nguyenhoaibao/vim-base64'
  use 'dhruvasagar/vim-zoom'
  use {
    'fatih/vim-go',
    tag = '*',
    run = ':GoInstallBinaries'
  }
  use 'AndrewRadev/splitjoin.vim'
  use 'rust-lang/rust.vim'
  use 'pangloss/vim-javascript'
  use 'leafgarland/typescript-vim'
  use 'tomlion/vim-solidity'
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use 'arcticicestudio/nord-vim'
  use 'nvim-lualine/lualine.nvim'
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
end)

local options = {
  termguicolors = true,
  number = true,
  relativenumber = true,
  numberwidth = 2,
  signcolumn = 'yes',
  splitbelow = true,
  splitright = true,
  ignorecase = true,
  smartcase = true,
  expandtab = true,
  shiftwidth = 2,
  softtabstop = 2,
  shiftround = true,
  swapfile = false,
  clipboard = 'unnamedplus',
  undofile = true,
  completeopt = 'menu,menuone,noselect',
  updatetime = 100,
}

vim.opt.shortmess:append 'c'

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.cmd [[
  augroup ex
    autocmd!
    " When editing a file, always jump to the last known cursor position.
    " Don't do it for commit messages, when the position is invalid, or when
    " inside an event handler (happens when dropping a file on gvim).
    autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
    autocmd BufReadPost fugitive://* set bufhidden=delete
  augroup end

  autocmd BufNewFile,BufRead *.{js,ts,yaml} setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
]]

--Remap space as leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--Remap for dealing with word wrap
vim.api.nvim_set_keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

vim.api.nvim_set_keymap('n', '<Leader>w', ':w<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>nh', ':noh<CR><c-l>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>[', ':bp<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>]', ':bn<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '[q', ':cprevious<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', ']q', ':cnext<CR>', { noremap = true })

vim.cmd [[ command! -bang -nargs=? W w<bang> <args> ]]
vim.cmd [[ command! -bang -nargs=? Wq wq<bang> <args> ]]
vim.cmd [[ command! -bang -nargs=? Wqa wqa<bang> <args> ]]
vim.cmd [[ command! -bang -nargs=? WQ wq<bang> <args> ]]
vim.cmd [[ command! -bang -nargs=? WQa wqa<bang> <args> ]]
vim.cmd [[ command! -bang -nargs=? Q qa!<bang> <args> ]]
vim.cmd [[ command! -bang -nargs=? Qa qa!<bang> <args> ]]

-- colorscheme
vim.cmd [[colorscheme nord]]
vim.g.nord_italic = 1
vim.g.nord_uniform_diff_background = 1

-- vim-better-whitespace
vim.g.strip_whitespace_on_save = 1
vim.g.strip_whitespace_confirm = 0

-- vim-terraform
vim.g.terraform_fmt_on_save = 1

-- vim-fugitive
vim.api.nvim_set_keymap('n', '<Leader>gt', ':Git commit -v -q %:p<CR>', { noremap = true })

-- nerdcommenter
vim.g.NERDSpaceDelims = 1
vim.g.NERDCompactSexyComs = 1
vim.g.NERDDefaultAlign = 'left'
vim.g.NERDCommentEmptyLines = 1
vim.g.NERDTrimTrailingWhitespace = 1

-- ultisnips
vim.g.UltiSnipsExpandTrigger="<c-j>"
vim.g.UltiSnipsJumpForwardTrigner="<c-b>"
vim.g.UltiSnipsJumpBackwardTrigger="<c-z>"

-- vim-tmux-navigator
vim.api.nvim_set_keymap('', '<BS>', ':<C-u>TmuxNavigateLeft<CR>', {})
vim.g.tmux_navigator_disable_when_zoomed = 1

-- vim-go
vim.g.go_imports_autosave = 0
vim.g.go_gopls_use_placeholders = 0
vim.g.go_term_mode = 'terminal'
vim.g.go_code_completion_enabled = 0
vim.g.go_doc_keywordprg_enabled = 0

--Set statusbar
require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = 'nord',
    component_separators = '|',
    section_separators = '',
  },
}

require('nvim-tree').setup {
  view = {
    mappings = {
      list = {
        { key = "x", action = "split" },
        { key = "v", action = "vsplit" },
      }
    }
  }
}
vim.api.nvim_set_keymap('n', '<Leader>d', ':NvimTreeToggle<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'F', ':NvimTreeFindFileToggle<CR>', { noremap = true })


--Map blankline
vim.g.indent_blankline_char = '┊'
vim.g.indent_blankline_filetype_exclude = { 'help', 'packer' }
vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
vim.g.indent_blankline_show_trailing_blankline_indent = false

-- Gitsigns
require('gitsigns').setup {
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
}

local actions = require("telescope.actions")
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<esc>'] = actions.close,
      },
    },
  },
}

-- Enable telescope fzf native
require('telescope').load_extension 'fzf'

vim.api.nvim_set_keymap('n', '<leader>pb', [[<cmd>lua require('telescope.builtin').buffers()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>pf', [[<cmd>lua require('telescope.builtin').find_files({previewer = false, hidden = true})<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '\\\\', [[<cmd>lua require('telescope.builtin').grep_string({hidden = true})<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '\\', [[<cmd>lua require('telescope.builtin').live_grep({hidden = true})<CR>]], { noremap = true, silent = true })

cfg = {
  bind = true,
  handler_opts = {
    border = 'rounded',
    hint_prefix = ''
  }
}
require 'lsp_signature'.setup(cfg)

-- Diagnostic keymaps
vim.diagnostic.config({virtual_text = false})
vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', { noremap = true, silent = true })

function org_imports(wait_ms)
  local params = vim.lsp.util.make_range_params()
  params.context = {only = {"source.organizeImports"}}
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
  for _, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        -- note: text encoding param is required
        vim.lsp.util.apply_workspace_edit(r.edit, "utf-16")
      else
        vim.lsp.buf.execute_command(r.command)
      end
    end
  end
end

vim.cmd [[
  augroup format_on_save
    autocmd!
    autocmd BufWritePre * lua vim.lsp.buf.formatting_sync(nil, 2000)
    autocmd BufWritePre *.go lua org_imports(1000)
  augroup END
]]

-- LSP settings
local lspconfig = require 'lspconfig'
local on_attach = function(_, bufnr)
  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
end

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

lspconfig.tsserver.setup {
  cmd = {"typescript-language-server", "--stdio"},
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.gopls.setup {
  cmd = {"gopls", "-remote=auto"},
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.rust_analyzer.setup {
  cmd = {"rust_analyzer"},
  on_attach = on_attach,
  capabilities = capabilities,
}

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn["vsnip#available"](1) == 1 then
        feedkey("<Plug>(vsnip-expand-or-jump)", "")
      elseif has_words_before() then
        cmp.complete()
      else
        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
      end
    end, { "i", "s" }),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
  },
  sources = {
    { name = 'nvim_lsp', priority = 100 },
    { name = 'vsnip', priority = 2 },
    { name = 'path', priority = 3 },
    { name = 'buffer', priority = 4 },
  }
}
-- vim: ts=2 sts=2 sw=2 et
