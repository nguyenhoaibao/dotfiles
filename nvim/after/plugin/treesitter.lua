local status, ts = pcall(require, 'nvim-treesitter.configs')
if not status then
  return
end

ts.setup {
  highlight = {
    enable = true,
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
  ensure_installed = {
    'go',
    'rust',
    'lua',
    'hcl',
    'yaml',
    'typescript',
  },
}
