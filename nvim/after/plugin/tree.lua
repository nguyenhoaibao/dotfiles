local status, tree = pcall(require, 'nvim-tree')
if not status then
  return
end

tree.setup {
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
