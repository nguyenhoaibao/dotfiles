-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', { command = 'source <afile> | PackerCompile', group = packer_group, pattern = 'init.lua' })

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
  -- use 'jiangmiao/auto-pairs'
  use 'windwp/nvim-autopairs'
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
  use 'simrat39/symbols-outline.nvim'
  use 'AndrewRadev/splitjoin.vim'
  use 'rust-lang/rust.vim'
  use 'pangloss/vim-javascript'
  use 'leafgarland/typescript-vim'
  use 'tomlion/vim-solidity'
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-live-grep-raw.nvim',
    },
  }
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
  wrap = false,
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
  updatetime = 250,
  timeoutlen = 350,

  -- foldmethod = 'expr',
  -- foldexpr = vim.fn['nvim_treesitter#foldexpr']()
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

  autocmd BufNewFile,BufRead *.{js,ts,yaml} setlocal expandtab softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=8 softtabstop=8 shiftwidth=8
]]

--Remap space as leader key
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.api.nvim_set_keymap('n', '<Leader>w', ':w<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>nh', ':noh<CR><c-l>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>[', ':bp<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>]', ':bn<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '[q', ':cprevious<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', ']q', ':cnext<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>sd', ':!sops -d -i %:p<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>se', ':!sops -e -i %:p<CR>', { noremap = true, silent = true })

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
-- vim.g.UltiSnipsExpandTrigger="<c-j>"
-- vim.g.UltiSnipsJumpForwardTrigner="<c-b>"
-- vim.g.UltiSnipsJumpBackwardTrigger="<c-z>"

-- vim-tmux-navigator
vim.api.nvim_set_keymap('', '<BS>', ':<C-u>TmuxNavigateLeft<CR>', {})
vim.g.tmux_navigator_disable_when_zoomed = 1

-- vim-go
vim.g.go_gopls_enabled = 0
vim.g.go_fmt_autosave = 0
vim.g.go_imports_autosave = 0
vim.g.go_gopls_use_placeholders = 0
vim.g.go_term_mode = 'terminal'
vim.g.go_code_completion_enabled = 0
vim.g.go_doc_keywordprg_enabled = 0

--
require('nvim-autopairs').setup{}

--
require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = 'nord',
    component_separators = '|',
    section_separators = '',
  },
}

--
require('nvim-tree').setup {
  view = {
    mappings = {
      list = {
        { key = "x", action = "split" },
        { key = "v", action = "vsplit" },
        { key = "m", action = "cut" },
      }
    }
  }
}
vim.cmd('autocmd BufWinEnter NvimTree_* setlocal cursorline')
vim.api.nvim_set_keymap('n', '<Leader>d', ':NvimTreeToggle<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'F', ':NvimTreeFindFileToggle<CR>', { noremap = true })

-- Gitsigns
require('gitsigns').setup {
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
  on_attach = function(bufnr)
    local function map(mode, lhs, rhs, opts)
        opts = vim.tbl_extend('force', {noremap = true, silent = true}, opts or {})
        vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
    end

    map('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", {expr=true})
    map('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", {expr=true})
    map('n', '<leader>hd', '<cmd>Gitsigns diffthis<CR>')
    map('n', '<leader>td', '<cmd>Gitsigns toggle_deleted<CR>')
  end
}

-- Treesitter configuration
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true, -- false will disable the whole extension
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'gnn',
      node_incremental = 'grn',
      scope_incremental = 'grc',
      node_decremental = 'grm',
    },
  },
  -- indent = {
  --   enable = true,
  -- },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        [']M'] = '@function.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>a"] = "@parameter.inner"
      },
      swap_previous = {
        ["<leader>A"] = "@parameter.inner"
      }
    }
  },
}

-- vim.o.foldmethod = 'expr'
-- vim.o.foldexpr = 'nvim_treesitter#foldexpr()'

-- Telescope
local actions = require("telescope.actions")
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<esc>'] = actions.close,
      },
    },
  },
  -- pickers = {
  --   find_files = {
  --     theme = "ivy",
  --   },
  --   live_grep = {
  --     theme = "ivy",
  --   }
  -- },
}

-- Enable telescope fzf native
require('telescope').load_extension 'fzf'

vim.keymap.set('n', '<leader>pb', require('telescope.builtin').buffers)
vim.keymap.set('n', '<leader>pf', function()
  require('telescope.builtin').find_files { previewer = false }
end)
vim.keymap.set('n', '\\\\', function()
  require('telescope.builtin').grep_string { hidden = true }
end)
vim.keymap.set('n', '\\', function()
  require('telescope.builtin').live_grep { hidden = true }
end)
vim.keymap.set('n', '\\r', function()
  require('telescope').extensions.live_grep_raw.live_grep_raw { hidden = true }
end)

cfg = {
  bind = true,
  hint_prefix = '',
  handler_opts = {
    border = 'none',
  },
}
require 'lsp_signature'.setup(cfg)

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

-- Diagnostic keymaps
vim.diagnostic.config({virtual_text = false})
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', 'ld', require('telescope.builtin').diagnostics)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- LSP settings
local lspconfig = require 'lspconfig'
local on_attach = function(client, bufnr)
  local opts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', '<C-]>', require('telescope.builtin').lsp_definitions, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', 'li', require('telescope.builtin').lsp_implementations, opts)
  vim.keymap.set('n', 'lrn', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', 'lr', require('telescope.builtin').lsp_references, opts)
  vim.keymap.set('n', 'lic', vim.lsp.buf.incoming_calls, opts)
  vim.keymap.set('n', 'loc', vim.lsp.buf.outgoing_calls, opts)
  vim.keymap.set('n', 'lca', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', 'lds', require('telescope.builtin').lsp_document_symbols, opts)
  vim.keymap.set('n', '<leader>gb', require('telescope.builtin').git_bcommits, opts)
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
  cmd = {"gopls", "serve"},
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    gopls = {
      usePlaceholders = false,
    },
  },
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
  preselect = cmp.PreselectMode.None,
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-u>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
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
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'path' },
    { name = 'buffer' },
  }
}
-- vim: ts=2 sts=2 sw=2 et
