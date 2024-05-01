local status, n = pcall(require, 'nvim-tmux-navigation')
if not status then
  return
end

n.setup {
  disable_when_zoomed = true,
  keybindings = {
    left = '<C-h>',
    down = '<C-j>',
    up = '<C-k>',
    right = '<C-l>',
    previous = '<C-\\>',
  },
  integrations = {
    fzf = true,
    telescope = true,
  },
}
