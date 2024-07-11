local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

augroup('indent', { clear = true })
autocmd('FileType', {
  group = 'indent',
  pattern = { 'lua', 'ts', 'tsx' },
  command = 'setlocal shiftwidth=2 tabstop=2'
})
autocmd('FileType', {
  group = 'indent',
  pattern = { 'rs' },
  command = 'setlocal shiftwidth=4 tabstop=4'
})

autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format({ bufnr = args.buf })
  end,
})
