return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    require('mason').setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "gopls",
        "pyright",
        'rust_analyzer',
        'jsonls',
        'tsserver',
        'lua_ls',
      }
    })
  end,
}
