local M = {}

M.setup = function(on_attach, capabilities, lsp_keymaps)
  require('go').setup({
    gofmt = 'gopls',
    lsp_cfg = {
      capabilities = capabilities,
    },
    lsp_keymaps = lsp_keymaps,
    lsp_diag_hdlr = true,
    lsp_inlay_hints = {
      enable = true,
    },
    run_in_floaterm = true,
  })
end

local go_fmt_group = vim.api.nvim_create_augroup('GoImport', { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = '*.go',
  group = go_fmt_group,
  callback = function()
    require('go.format').goimport()
  end,
})

return M
