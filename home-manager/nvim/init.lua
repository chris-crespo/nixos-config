local api = vim.api
local cmd = vim.cmd
local opt = vim.opt

cmd.colorscheme 'catppuccin-mocha'
-- set mouse=

opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true

api.nvim_create_autocmd("FileType", { 
  pattern = "make", 
  command = [[set noexpandtab shiftwidth=4]]
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
