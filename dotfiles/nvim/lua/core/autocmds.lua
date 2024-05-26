local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

augroup('indent', { clear = true })
autocmd('FileType', {
  group = 'indent',
  pattern = { 'lua' },
  command = 'setlocal shiftwidth=2 tabstop=2'
})
autocmd('FileType', {
  group = 'indent',
  pattern = { 'rs' },
  command = 'setlocal shiftwidth=4 tabstop=4'
})

