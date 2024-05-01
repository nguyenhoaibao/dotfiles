local null_ls = require("null-ls")
local b = null_ls.builtins
local M = {}

local sources = {
  b.formatting.prettier.with {
    condition = function(utils)
      return utils.root_has_file(".prettierrc")
    end,
  }
}

M.setup = function(on_attach, capabilities)
  null_ls.setup({
    sources = sources,
    on_attach = on_attach,
  })
end

return M
