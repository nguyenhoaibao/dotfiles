local status, ap = pcall(require, 'nvim-autopairs')
if not status then
  return
end

ap.setup{}
