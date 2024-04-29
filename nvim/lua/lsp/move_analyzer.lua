local M = {}

M.setup = function(on_attach, capabilities)
  require('lspconfig').move_analyzer.setup {}
end

return M
