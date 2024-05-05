return {
  'numToStr/Comment.nvim',
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  config = function()
    require('Comment').setup({
      padding = true,
      sticky = true,
      toggler = {
        line = '<Leader>cc',
        block = '<Leader>bc',
      },
      opleader = {
        line = '<Leader>c',
        block = '<Leader>b',
      },
    })
  end,
}
