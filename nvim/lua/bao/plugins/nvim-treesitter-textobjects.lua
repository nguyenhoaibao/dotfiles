return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  lazy = true,
  -- dependencies = {
  --   { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  -- },
  -- dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("nvim-treesitter.configs").setup({
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            [']m'] = '@function.outer',
            ["]]"] = "@class.outer",
          },
          goto_next_end = {
            [']M'] = '@function.outer',
          },
          goto_previous_start = {
            ['[m'] = '@function.outer',
            ["[["] = "@class.outer",
          },
          goto_previous_end = {
            ['[M'] = '@function.outer',
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ["<leader>na"] = "@parameter.inner"
          },
          swap_previous = {
            ["<leader>nA"] = "@parameter.inner"
          }
        },
      },
    })
  end,
}
