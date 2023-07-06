local status, lspconfig = pcall(require, 'lspconfig')
if not status then
  return
end

local lsp_keymaps = function(bufnr)
  local opts = { silent = true, buffer = bufnr }
  local bind = function(keys, func)
    vim.keymap.set('n', keys, func, opts)
  end

  bind('<C-]>', ':Telescope lsp_definitions<CR>')
  bind('K', vim.lsp.buf.hover)
  bind('gi', ':Telescope lsp_implementations<CR>')
  bind('gD', ':Telescope lsp_type_definitions<CR>')
  bind('gr', ':Telescope lsp_references<CR>')
  bind('<Leader>ic', ':Telescope lsp_incoming_calls<CR>')
  bind('<Leader>oc', ':Telescope lsp_outgoing_calls<CR>')
  bind('<Leader>rn', vim.lsp.buf.rename)
  bind('<Leader>ca', vim.lsp.buf.code_action)
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local on_attach = function(client, bufnr)
  lsp_keymaps(bufnr)
  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format { async = false }
      end,
    })
  end
end

-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
local capabilities = require('cmp_nvim_lsp').default_capabilities()

require("mason").setup()

local servers = {
  'go',
  'move_analyzer',
  'null-ls',
  'pyright',
  'rust_analyzer',
  -- 'solidity_ls',
  'sumneko_lua',
  'terraformls',
  'tsserver',
}

require("mason-lspconfig").setup({
  automatic_installation = true,
})

for _, server in ipairs(servers) do
  if server == 'go' then
    require('lsp.go').setup(on_attach, capabilities, lsp_keymaps)
  else
    require("lsp." .. server).setup(on_attach, capabilities)
  end
end
