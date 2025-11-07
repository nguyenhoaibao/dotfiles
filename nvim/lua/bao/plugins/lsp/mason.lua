return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    version = "*",
    config = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    version = "*",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      'williamboman/mason.nvim'
    },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "gopls",
          "pyright",
          'rust_analyzer',
          'jsonls',
          'ts_ls',
          'lua_ls',
          'solidity_ls_nomicfoundation',
        }
      })
    end,
  }
}
