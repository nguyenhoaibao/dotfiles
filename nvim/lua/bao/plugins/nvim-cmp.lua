return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    {
      "L3MON4D3/LuaSnip",
      -- follow latest release.
      version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
      -- install jsregexp (optional!).
      build = "make install_jsregexp"
    },
    'saadparwaiz1/cmp_luasnip',
    'onsails/lspkind-nvim',
  },
  config = function()
    local cmp = require('cmp')

    cmp.setup({
      preselect = cmp.PreselectMode.None,
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end,
      },
      formatting = {
        format = require('lspkind').cmp_format({
          mode = 'symbol',
          menu = ({
            buffer = "[Buffer]",
            luasnip = "[LuaSnip]",
            nvim_lsp = "[LSP]",
          }),
        }),
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-u>'] = cmp.mapping.scroll_docs(4),
        -- ['<C-Space>'] = cmp.mapping(function(fallback)
        --   local copilot_keys = vim.fn["copilot#Accept"]()
        --   if copilot_keys ~= '' then
        --     vim.api.nvim_feedkeys(copilot_keys, 'i', true)
        --   else
        --     fallback()
        --   end
        -- end),
        ['<C-Space>'] = cmp.mapping(function(fallback)
          vim.api.nvim_feedkeys(vim.fn['copilot#Accept'](vim.api.nvim_replace_termcodes('<Tab>', true, true, true)), 'n',
            true)
        end),
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif require('luasnip').expand_or_jumpable() then
            require('luasnip').expand_or_jump()
          else
            local copilot_keys = vim.fn["copilot#Accept"]()
            if copilot_keys ~= '' then
              vim.api.nvim_feedkeys(copilot_keys, 'i', true)
            else
              fallback()
            end
          end
        end, { 'i', 's' }),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
      }),
      experimental = {
        ghost_text = false,
      },
      sources = cmp.config.sources({
        { name = 'nvim_lsp', keyword_length = 3 },
        { name = 'luasnip' },
        { name = 'path' },
        { name = 'buffer',   keyword_length = 4 },
      }),
    })
  end,
}
