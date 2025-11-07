local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
end

return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    {
      "L3MON4D3/LuaSnip",
      -- follow latest release.
      version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
      -- install jsregexp (optional!).
      build = "make install_jsregexp"
    },
    'saadparwaiz1/cmp_luasnip',
    'onsails/lspkind-nvim',
    -- 'zbirenbaum/copilot-cmp',
  },
  config = function()
    local cmp = require('cmp')
    local luasnip = require('luasnip')

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
            cmp.select_next_item({})
            -- elseif require('luasnip').expand_or_jumpable() then
          elseif luasnip.locally_jumpable(1) then
            -- require('luasnip').expand_or_jump()
            luasnip.jump(1)
          else
            fallback()
            -- local copilot_keys = vim.fn["copilot#Accept"]()
            -- if copilot_keys ~= '' then
            --   vim.api.nvim_feedkeys(copilot_keys, 'i', true)
            -- else
            --   fallback()
            -- end
          end
        end, { 'i', 's' }),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp',               group_index = 2,   keyword_length = 3 },
        { name = 'luasnip',                group_index = 2 },
        { name = 'path',                   group_index = 2 },
        { name = "nvim_lsp_signature_help" },
        { name = 'buffer',                 keyword_length = 4 },
      }),
    })
  end,
}
