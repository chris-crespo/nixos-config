local function on_attach(client, bufnr)
  local opts = { buffer = bufnr }
  vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<leader>F', vim.lsp.buf.format, opts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)

  vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)
end

require'lspconfig.ui.windows'.default_options_border = 'rounded'

vim.diagnostic.config({
  virtual_text = false,
  update_in_insert = true,
  underline = true,
  float = {
    border = 'rounded',
    source = true,
  }
})

local lspconfig = require'lspconfig'
local capabilities = vim.lsp.protocol.make_client_capabilities()

local cmp_nvim_lsp = require'cmp_nvim_lsp'
capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

lspconfig.lua_ls.setup {
  on_attach = on_attach,
  capabilitites = capabilities,
  settings = {
    Lua = {
      runtime = 'LuaJIT',
      diagnostics = {
        globals = { 'vim' }
      },
      workspace = {
        checkThirdParty = false,
        library = vim.api.nvim_get_runtime_file("", true)
      },
      telemetry = {
        enabled = false
      }
    }
  }
}

lspconfig.ccls.setup {
  on_attach = on_attach,
  capabilitites = capabilities
}

lspconfig.zls.setup {
  on_attach = on_attach,
  capabilitites = capabilities
}

vim.g.haskell_tools = {
  hls = {
    on_attach = on_attach,
  }
}

vim.g.rustaceanvim = {
	server = {
		on_attach = on_attach
	}
}

require'typescript-tools'.setup {
  on_attach = on_attach
}
