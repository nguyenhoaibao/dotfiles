local status, so = pcall(require, 'symbols-outline')
if not status then
  return
end

so.setup()
