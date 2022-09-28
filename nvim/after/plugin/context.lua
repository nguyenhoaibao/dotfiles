local status, tc = pcall(require, 'treesitter-context')
if not status then
	return
end

tc.setup()
