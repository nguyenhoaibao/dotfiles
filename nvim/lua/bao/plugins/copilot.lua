return {
  'github/copilot.vim',
  version = "*",
  config = function()
    vim.g.copilot_no_tab_map = true
    vim.g.copilot_assume_mapped = true
    vim.g.copilot_tab_fallback = ""

    -- https://github.com/orgs/community/discussions/151719#discussioncomment-12607316
    vim.g.copilot_settings = { selectedCompletionModel = 'gpt-4o-copilot' }
    -- vim.g.copilot_integration_id = 'vscode-chat'

    -- vim.cmd[[imap <silient><script><expr> <C-Space> copilot#Accept("\<Tab>")]]
    vim.g.copilot_filetypes = {
      ["TelescopeResults"] = false,
      ["TelescopePrompt"] = false,
    }
  end
}
-- return {
--   "zbirenbaum/copilot.lua",
--   cmd = "Copilot",
--   event = "InsertEnter",
--   config = function()
--     require("copilot").setup({
--       suggestion = {
--         keymap = {
--           accept = "<C-Space>",
--           next = "<C-]>",
--         }
--       }
--     })
--   end,
-- }
