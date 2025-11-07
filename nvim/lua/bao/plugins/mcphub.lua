return {
  "ravitemer/mcphub.nvim",
  -- commit = "e95eb8f3af5c72258ba2b5e281092c20692516fd",
  dependencies = {
    "nvim-lua/plenary.nvim",               -- Required for Job and HTTP requests
  },
  build = "npm install -g mcp-hub@latest", -- Installs required mcp-hub npm module
  cmd = "MCPHub",                          -- lazy load by default
  config = function()
    require("mcphub").setup({
      auto_approve = true,
    })
  end
}
