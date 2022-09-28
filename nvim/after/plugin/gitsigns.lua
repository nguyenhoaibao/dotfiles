local status, gitsigns = pcall(require, 'gitsigns')
if not status then
  return
end

gitsigns.setup {
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function bind(mode, keys, func, opts)
      opts = vim.tbl_extend('force', { silent = true, buffer = bufnr }, opts or {})
      vim.keymap.set(mode, keys, func, opts)
    end

    bind('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, { expr = true })

    bind('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr = true })

    bind('n', '<Leader>hd', gitsigns.diffthis)
    bind({ 'n', 'v' }, '<Leader>hs', ':Gitsigns stage_hunk<CR>')
    bind({ 'n', 'v' }, '<Leader>hr', ':Gitsigns reset_hunk<CR>')
    bind('n', '<Leader>hS', gs.stage_buffer)
    bind('n', '<leader>hu', gs.undo_stage_hunk)
    bind('n', '<Leader>hR', gs.reset_buffer)
    bind('n', '<Leader>hp', gs.preview_hunk)
    bind('n', '<Leader>td', gs.toggle_deleted)
    bind('n', '<leader>tb', gs.toggle_current_line_blame)
  end
}
