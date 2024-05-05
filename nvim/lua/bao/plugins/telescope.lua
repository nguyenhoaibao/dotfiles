return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local telescope = require('telescope')
    local actions = require('telescope.actions')
    local builtin = require('telescope.builtin')

    telescope.setup {
      defaults = {
        extensions = {
          fzf = {
            override_generic_sorter = false,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
        vimgrep_arguments = {
          'rg',
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--smart-case',
          '--hidden'
        },
        mappings = {
          i = {
            ['<esc>'] = actions.close,
          },
        },
      },
    }

    telescope.load_extension('fzf')

    -- Keybindings
    local bind = vim.keymap.set
    local opts = { silent = true }

    bind('n', '<Leader>pb', builtin.buffers, opts)
    bind('n', '<Leader>pf', function()
      builtin.find_files { hidden = true, previewer = false }
    end, opts)
    bind('n', '<Leader>/', function()
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, opts)
    bind('n', '\\\\', builtin.grep_string, opts)
    bind('n', '\\', builtin.live_grep, opts)
    bind('n', '<Leader>gy', builtin.git_stash, opts)
    bind('n', '<Leader>gb', builtin.git_bcommits, { desc = 'List Git buffer commits', silent = true })
    -- vim.api.nvim_set_keymap('v', '<Leader>gbr', '<cmd>lua require("telescope.builtin").git_bcommits_range()<CR>',
    --   { noremap = true, silent = true })
    bind('n', '<Leader>fs', builtin.git_branches, { desc = 'List Git branches', silent = true })
  end,
}
