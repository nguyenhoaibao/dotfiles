local status, sig = pcall(require, 'lsp_signature')
if not status then
  return
end

sig.setup({
  bind = true,
  hint_prefix = '',
  handler_opts = {
    border = 'none',
  },
})
