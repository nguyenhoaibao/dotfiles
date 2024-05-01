local status, tree = pcall(require, 'nvim-tree')
if not status then
  return
end

local function on_attach(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  api.config.mappings.default_on_attach(bufnr)

  vim.keymap.set('n', 'x', api.node.open.horizontal, opts('Open: Horizontal Split'))
  vim.keymap.set('n', 'v', api.node.open.vertical, opts('Open: Vertical Split'))
  vim.keymap.set('n', 'm', api.fs.cut, opts('Cut'))
  vim.keymap.set('n', 'd', api.fs.trash, opts('Trash'))
end

tree.setup({
  on_attach = on_attach,
  view = {
    adaptive_size = true,
  }
})

vim.cmd('autocmd BufWinEnter NvimTree_* setlocal cursorline')
