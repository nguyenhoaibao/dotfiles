return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'ray-x/go.nvim',
  },
  config = function()
    local lspconfig = require('lspconfig')
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local tls_builtin = require("telescope.builtin")

    local keymaps = function(bufnr)
      local opts = { buffer = bufnr, silent = true }
      local bind = vim.keymap.set

      bind('n', '<C-]>', tls_builtin.lsp_definitions, opts)

      opts.desc = "Go to declaration"
      bind("n", "gd", vim.lsp.buf.declaration, opts)

      opts.desc = 'Go to Implementation'
      bind('n', 'gi', tls_builtin.lsp_implementations, opts)

      opts.desc = 'Go to Type Definition'
      bind('n', 'gt', tls_builtin.lsp_type_definitions, opts)

      opts.desc = 'Go to References'
      bind('n', 'gr', tls_builtin.lsp_references, opts)

      opts.desc = 'Show buffer diagnostics'
      bind('n', '<Leader>ld', '<cmd>Telescope diagnostics bufnr=0<cr>', opts)

      opts.desc = 'List Diagnostics'
      bind('n', '<leader>lD', tls_builtin.diagnostics, opts)

      opts.desc = 'Show line diagnostics'
      bind('n', '<Leader>e', vim.diagnostic.open_float, opts)

      opts.desc = 'Go to previous diagnostic'
      bind('n', '[d', vim.diagnostic.goto_prev, opts)

      opts.desc = 'Go to next diagnostic'
      bind('n', ']d', vim.diagnostic.goto_next, opts)

      opts.desc = 'List Incoming Calls'
      bind('n', '<Leader>ic', tls_builtin.lsp_incoming_calls, opts)

      opts.desc = 'List Outgoing Calls'
      bind('n', '<Leader>oc', tls_builtin.lsp_outgoing_calls, opts)

      opts.desc = 'Show Hover'
      bind('n', 'K', vim.lsp.buf.hover, opts)

      opts.desc = 'Rename'
      bind('n', '<Leader>rn', vim.lsp.buf.rename, opts)

      opts.desc = 'Code Action'
      bind('n', '<Leader>ca', vim.lsp.buf.code_action, opts)
    end

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        keymaps(ev.buf)
      end,
    })

    -- used to enable autocompletion (assign to every lsp server config)
    -- local capabilities = cmp_nvim_lsp.default_capabilities()
    local capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())

    require('mason-lspconfig').setup_handlers({
      function(server_name)
        lspconfig[server_name].setup({
          capabilities = capabilities,
        })
      end,
      ["gopls"] = function()
        require('go').setup({
          gofmt = 'gopls',
          lsp_cfg = {
            capabilities = capabilities,
          },
          lsp_keymaps = false,
          run_in_floaterm = true,
        })
      end,
      ["lua_ls"] = function()
        lspconfig["lua_ls"].setup({
          capabilities = capabilities,
          settings = {
            Lua = {
              diagnostics = {
                globals = { 'vim' },
              },
            },
          },
        })
      end,
    })
  end
}
