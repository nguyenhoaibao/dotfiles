return {
  'nvim-tree/nvim-tree.lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    require('nvim-tree').setup {
      on_attach = function(bufnr)
        local api = require('nvim-tree.api')

        local function opts(desc)
          return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        api.config.mappings.default_on_attach(bufnr)

        vim.keymap.set('n', 'x', api.node.open.horizontal, opts('Open: Horizontal Split'))
        vim.keymap.set('n', 'v', api.node.open.vertical, opts('Open: Vertical Split'))
        vim.keymap.set('n', 'm', api.fs.cut, opts('Cut'))
        vim.keymap.set('n', 'd', api.fs.trash, opts('Trash'))
      end,
      view = {
        adaptive_size = true,
      },
    }

    vim.cmd('autocmd BufWinEnter NvimTree_* setlocal cursorline')

    vim.keymap.set('n', '<Leader>d', ':NvimTreeToggle<CR>', { silent = true })
    vim.keymap.set('n', 'F', ':NvimTreeFindFileToggle<CR>', { silent = true })
  end,
}
