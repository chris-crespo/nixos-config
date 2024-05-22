local function on_attach(client, buffer)
  local opts = { buffer = buffer }
  vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', '<leader>F', vim.lsp.buf.format, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
end

require 'lspconfig.ui.windows'.default_options.border = 'rounded'

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local lspconfig = require 'lspconfig'

lspconfig.astro.setup {
  on_attach = on_attach,
  filetypes = { "astro" }
}

require 'neodev'.setup {}

lspconfig.lua_ls.setup {
  on_attach = on_attach,
}

lspconfig.hls.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

lspconfig.tsserver.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  root_dir = lspconfig.util.root_pattern("package.json"),
  single_file_support = false
}

vim.g.rustaceanvim = {
  server = {
    on_attach = on_attach,
    capabilities = capabilities
  }
}

-- vim.g.rustaceanvim.server.on_attach = on_attach;

-- require 'rust-tools'.setup {
--   tools = {
--     runnables = {
--       use_telescope = true
--     },
--     inlay_hints = {
--       auto = false, -- inlay_hints are broken
--       show_parameter_hints = false,
--       parameter_hints_prefix = "",
--       other_hints_prefix = ""
--     },
--   },
--   server = {
--     capabilities = capabilities,
--     on_attach = on_attach,
--     settings = {
--       ['rust-analyzer'] = {
--         checkOnSave = {
--           command = 'clippy'
--         },
--         cargo = {
--           allFeatures = true
--         }
--       }
--     }
--   }
-- }
