local null_ls = require("null-ls")
local b = null_ls.builtins
local M = {}

M.setup = function(on_attach, capabilities)
  null_ls.setup({
    sources = {
      b.formatting.buf,
    },
    on_attach = on_attach,
  })
end

return M
