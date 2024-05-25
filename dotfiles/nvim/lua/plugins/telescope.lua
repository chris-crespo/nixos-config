require 'telescope'.setup {
  defaults = {
    mappings = {
      i = {
        ['<C-p>'] = require 'telescope.actions.layout'.toggle_preview
      }
    },
    preview = {
      hide_on_startup = true
    }
  }
}
