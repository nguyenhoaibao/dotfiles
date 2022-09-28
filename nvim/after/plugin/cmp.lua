local status, cmp = pcall(require, 'cmp')
if not status then
  return
end

local luasnip = require('luasnip')
local lspkind = require('lspkind')

-- local has_words_before = function()
--   local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--   return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
-- end

local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
end

-- local check_backspace = function()
--   local col = vim.fn.col "." - 1
--   return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
-- end

cmp.setup {
  preselect = cmp.PreselectMode.None,
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol_text',
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
    -- ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-Space>'] = cmp.mapping(function(fallback)
      vim.api.nvim_feedkeys(vim.fn['copilot#Accept'](vim.api.nvim_replace_termcodes('<Tab>', true, true, true)), 'n', true)
    end),
    -- ['<C-Space>'] = cmp.mapping(function(fallback)
    --     local copilot_keys = vim.fn["copilot#Accept"]("")
    --     if copilot_keys ~= '' then
    --       vim.api.nvim_feedkeys(copilot_keys, 'i', true)
    --     else
    --       cmp.mapping.complete()
    --     end
    -- end),
    -- ['<Tab>'] = cmp.mapping(function(fallback)
    --   if cmp.visible() then
    --     cmp.select_next_item()
    --   elseif luasnip.expandable() then
    --     luasnip.expand()
    --   elseif luasnip.expand_or_jumpable() then
    --     luasnip.expand_or_jump()
    --   elseif check_backspace() then
    --     fallback()
    --   elseif has_words_before() then
    --     cmp.complete()
    --   else
    --     fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
    --   end
    -- end, { "i", "s" }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      -- elseif has_words_before() then
      --   cmp.complete()
      else
        local copilot_keys = vim.fn["copilot#Accept"]()
        if copilot_keys ~= '' then
          vim.api.nvim_feedkeys(copilot_keys, 'i', true)
        else
          fallback()
        end
      end
    end, { "i", "s" }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  experimental = {
    ghost_text = false -- this feature conflict with copilot.vim's preview.
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp', keyword_length = 3 },
    { name = 'luasnip' },
    { name = 'path' },
    { name = 'buffer', keyword_length = 4 },
  }),
}

cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'buffer' },
  }),
})
