-- vim-better-whitespace
vim.g.strip_whitespace_on_save = 1
vim.g.strip_whitespace_confirm = 0

-- vim-tmux-navigator
vim.keymap.set('', '<BS>', ':<C-u>TmuxNavigateLeft<CR>', {})
vim.g.tmux_navigator_disable_when_zoomed = 1

-- copilot
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.g.copilot_tab_fallback = ""
