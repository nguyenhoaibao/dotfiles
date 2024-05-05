return {
  'lewis6991/gitsigns.nvim',
  event = { "BufReadPre", "BufNewFile" },
  opts = {
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
      end, { expr = true })

      local opts = { buffer = bufnr, silent = true }

      opts.desc = 'Diff this file against the index'
      bind('n', '<Leader>hd', gs.diffthis, opts)

      opts.desc = 'Stage this hunk'
      bind({ 'n', 'v' }, '<Leader>hs', gs.stage_hunk, opts)

      opts.desc = 'Undo stage this hunk'
      bind({ 'n', 'v' }, '<Leader>hr', gs.undo_stage_hunk, opts)

      opts.desc = 'Stage this buffer'
      bind('n', '<Leader>hS', gs.stage_buffer, opts)

      opts.desc = 'Reset this buffer'
      bind('n', '<Leader>hR', gs.reset_buffer, opts)

      opts.desc = 'Preview hunk'
      bind('n', '<Leader>hp', gs.preview_hunk, opts)

      opts.desc = 'Toggle deleted line'
      bind('n', '<Leader>td', gs.toggle_deleted, opts)

      opts.desc = 'Blame line'
      bind('n', '<leader>hb', gs.toggle_current_line_blame, opts)
    end,
  }
}
