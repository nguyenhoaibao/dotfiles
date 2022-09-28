local status, telescope = pcall(require, 'telescope')
if not status then
  return
end

local bind = vim.keymap.set
local actions = require("telescope.actions")

telescope.setup {
  defaults = {
    extension = {
      fzf = {
        fuzzy = true,                    -- false will only do exact matching
        override_generic_sorter = true,  -- override the generic sorter
        override_file_sorter = true,     -- override the file sorter
      }
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
  -- pickers = {
  --   find_files = {
  --     theme = "dropdown",
  --   },
  --   live_grep = {
  --     theme = "dropdown",
  --   }
  -- },
}

telescope.load_extension('fzf')
