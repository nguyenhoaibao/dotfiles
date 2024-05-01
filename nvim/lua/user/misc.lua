-- vim-better-whitespace
vim.g.strip_whitespace_on_save = 1
vim.g.strip_whitespace_confirm = 0

-- copilot
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.g.copilot_tab_fallback = ""
-- vim.cmd[[imap <silient><script><expr> <C-Space> copilot#Accept("\<Tab>")]]
vim.g.copilot_filetypes = {
  ["TelescopeResults"] = false,
  ["TelescopePrompt"] = false,
}
