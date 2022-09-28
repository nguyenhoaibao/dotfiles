local status, lualine = pcall(require, 'lualine')
if not status then
  return
end

lualine.setup {
  options = {
    icons_enabled = false,
    theme = 'nord',
    component_separators = '|',
    section_separators = '',
  },
}
