return {
  'neovim/nvim-lspconfig',
  version = "*",
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'nvim-treesitter/nvim-treesitter',
    {
      'ray-x/go.nvim',
      version = "*",
      event = { "CmdlineEnter" },
      ft = { "go", 'gomod' },
      dependencies = { -- optional packages
        "ray-x/guihua.lua",
      },
    },
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

    vim.api.nvim_create_augroup("UserLspConfig", {})
    vim.api.nvim_create_autocmd("LspAttach", {
      -- group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      group = "UserLspConfig",
      callback = function(args)
        keymaps(args.buf)

        -- vim.lsp.inlay_hint.enable(true, { 0 })

        if not (args.data and args.data.client_id) then
          return
        end
        -- local bufnr = args.buf
        -- local client = vim.lsp.get_client_by_id(args.data.client_id)
        -- require("lsp-inlayhints").on_attach(client, bufnr)
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
            settings = {
              gopls = {
                analyses = {
                  fieldalignment = false,
                }
              }
            }
          },
          lsp_keymaps = false,
          lsp_inlay_hints = {
            enable = false,
          },
          run_in_floaterm = true,
          luasnip = false,
          iferr_vertical_shift = 4,
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
      ["rust_analyzer"] = function()
        lspconfig["rust_analyzer"].setup({
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
          },
        })
      end,
    })
  end
}
