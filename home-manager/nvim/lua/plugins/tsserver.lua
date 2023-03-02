function on_attach(client, buffer)
  local opts = { buffer = buffer }
  vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
end

require 'lspconfig'.tsserver.setup {
  on_attach = on_attach,
  filetypes = { "typescript", "typescriptreact" }
}
