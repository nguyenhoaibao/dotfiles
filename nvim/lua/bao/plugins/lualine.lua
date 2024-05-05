return {
  'nvim-lualine/lualine.nvim',
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require('lualine').setup {
      options = {
        icons_enabled = false,
        theme = 'nord',
        component_separators = '|',
        section_separators = '',
      },
      sections = {
        lualine_c = { 'filename', function() return vim.t.maximized and '  ' or '' end }
      }
    }
  end,
}
