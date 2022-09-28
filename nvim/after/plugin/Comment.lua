local status, comment = pcall(require, 'Comment')
if not status then
  return
end

comment.setup({
  padding = true,
  sticky = true,
  toggler = {
    line = '<Leader>cc',
    block = '<Leader>bc',
  },
  opleader = {
    line = '<Leader>c',
    block = '<Leader>b',
  },
})
