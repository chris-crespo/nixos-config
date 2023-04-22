local api = vim.api
local cmd = vim.cmd

cmd.colorscheme 'catppuccin-mocha'
-- set mouse=

vim.cmd [[
  set tabstop=2
  set shiftwidth=2
  set expandtab
]]

api.nvim_create_autocmd("FileType", {
  pattern = "make",
  command = [[
    set noexpandtab shiftwidth=4
  ]]
})

vim.wo.signcolumn = "yes"
vim.diagnostic.config({
  virtual_text = false,
  update_in_insert = true,
  underline = true,
  float = {
    border = 'rounded',
    source = 'always',
  }
})

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'rounded'
})
