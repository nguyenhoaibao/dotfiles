local null_ls = require("null-ls")
local M = {}
local sources = {
  null_ls.builtins.formatting.prettier.with {
    condition = function(utils)
      return utils.root_has_file { ".prettierrc" }
    end,
  },
}

M.setup = function(on_attach, capabilities)
  null_ls.setup({
    on_attach = on_attach,
    sources = sources,
  })
end

return M
