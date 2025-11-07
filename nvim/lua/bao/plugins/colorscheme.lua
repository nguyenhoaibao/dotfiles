-- return {
--   'arcticicestudio/nord-vim',
--   branch = "main",
--   priority = 1000,
--   config = function()
--     vim.cmd('colorscheme nord')
--   end,
-- }
return {
  -- 'sainnhe/everforest',
  'neanias/everforest-nvim',
  version = false,
  lazy = false,
  priority = 1000,
  config = function()
    -- Optionally configure and load the colorscheme
    -- directly inside the plugin declaration.
    -- vim.g.everforest_enable_italic = true
    -- vim.g.everforest_background = "hard"
    -- vim.cmd.colorscheme('everforest')
    -- vim.api.nvim_set_hl(0, "LspInlayHint", { fg = "#9DA9A0" })

    require("everforest").load()
  end
}
