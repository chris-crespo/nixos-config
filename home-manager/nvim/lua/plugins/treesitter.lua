require 'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true
  },
  autotag = {
    enable = true,
    enable_close = true,
    enable_close_on_slash = true,
    ename_rename = true,
    filetypes = {
      'html'
    }
  }
}
