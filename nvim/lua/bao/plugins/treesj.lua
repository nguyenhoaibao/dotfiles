return {
  'Wansmer/treesj',
  keys = {
    { 'gS', '<cmd>lua require("treesj").split()<cr>', desc = 'Split arguments' },
    { 'gJ', '<cmd>lua require("treesj").join()<cr>',  desc = 'Join arguments' },
  },
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    require('treesj').setup()
  end,
}
