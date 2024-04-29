local M = {}

M.setup = function(on_attach, capabilities)
  require('lspconfig').tsserver.setup({
    on_attach = function(client)
      -- client.resolved_capabilities.document_formatting = false
      on_attach(client)
    end,
    capabilities = capabilities,
  })
end

return M
