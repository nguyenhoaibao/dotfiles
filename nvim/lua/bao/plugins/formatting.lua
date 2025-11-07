return {
  "stevearc/conform.nvim",
  event = { 'BufWritePre' },
  opts = {
    formatters_by_ft = {
      javascript = { "prettier" },
      typescript = { "prettier" },
      json = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      lua = { "stylua" },
      go = { "goimports" },
      rust = { "rustfmt" }
    },
    default_format_opts = {
      lsp_format = "fallback"
    },
    format_on_save = {
      async = false,
      timeout_ms = 1000,
    },
  },
}
