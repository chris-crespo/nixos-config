require 'nvim-tree'.setup {
  diagnostics = {
    enable = true
  },
  sort_by = 'case_sensitive',
  view = {
    mappings = {
      list = {
        { key = 'h', action = 'close_node' },
        { key = 'l', action = 'open_node' }
      }
    }
  }
}
