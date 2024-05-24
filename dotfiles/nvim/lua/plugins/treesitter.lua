require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false
  },
  indent = { enable = true },
  ensure_installed = { 'lua' },

  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ['ab'] = "@block.outer",
        ['ib'] = '@block.inner',
        ["af"] = "@function.outer",
        ["if"] = "@function.inner"
      },
      selection_modes = {
        ['@block.inner'] = 'v',
        ['@block.outer'] = 'v',
        ['@function.inner'] = 'V',
        ['@function.outer'] = 'V',
      }
    }
  }
}
