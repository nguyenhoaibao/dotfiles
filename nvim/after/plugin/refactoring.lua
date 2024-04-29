local status, rr = pcall(require, 'refactoring')
if not status then
  return
end

rr.setup()
