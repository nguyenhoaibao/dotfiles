local status, lspconfig = pcall(require, 'lspconfig')
if (not status) then
  return
end

local lsp_keymaps = function(bufnr)
  local opts = {silent = true, buffer = bufnr}
  local bind = function(keys, func)
    vim.keymap.set('n', keys, func, opts)
  end

  bind('<C-]>', ':Telescope lsp_definitions<CR>')
  bind('K', vim.lsp.buf.hover)
  bind('li', ':Telescope lsp_implementations<CR>')
  bind('lrn', vim.lsp.buf.rename)
  bind('lr', ':Telescope lsp_references<CR>')
  bind('lic', ':Telescope lsp_incoming_calls<CR>')
  bind('loc', ':Telescope lsp_outgoing_calls<CR>')
  bind('lca', vim.lsp.buf.code_action)
  bind('lds', ':Telescope lsp_document_symbols<CR>')
end

local on_attach = function(client, bufnr)
  lsp_keymaps(bufnr)
end

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

lspconfig.tsserver.setup {
  cmd = {"typescript-language-server", "--stdio"},
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.rust_analyzer.setup {
  cmd = {"rust-analyzer"},
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    ["rust-analyzer"] = {
      assist = {
        importGranularity = "module",
        importPrefix = "self",
      },
      cargo = {
        loadOutDirsFromCheck = true
      },
      procMacro = {
        enable = true
      },
    }
  }
}

lspconfig.terraformls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

require("mason").setup()
require("mason-lspconfig").setup()

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    vim.lsp.buf.formatting_sync(nil, 3000)
  end,
})

-- use go.nvim plugin for Go code
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

local go_fmt_group = vim.api.nvim_create_augroup('go_fmt', { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = '*.go',
  group = go_fmt_group,
  callback = function()
    require('go.format').goimport()
  end,
})

require("null-ls").setup({
  sources = {
    require("null-ls").builtins.formatting.buf,
  },
})
