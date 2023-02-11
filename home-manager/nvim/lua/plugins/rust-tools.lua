local rt = require 'rust-tools'

function on_attach(client, buffer)
  local opts = { buffer = buffer }
  vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  --
end

rt.setup {
  tools = {
    runnables = {
      use_telescope = true
    },
    inlay_hints = {
      auto = false, -- inlay_hints are broken
      show_parameter_hints = false,
      parameter_hints_prefix = "",
      other_hints_prefix = ""
    },
  },
  server = {
    on_attach = on_attach,
    settings = {
      ['rust-analyzer'] = {
        checkOnSave = {
          command = 'clippy'
        }
      }
    }
  }
}
