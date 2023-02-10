local cmd = vim.cmd
local opt = vim.opt

cmd.colorscheme 'catppuccin-mocha'
-- set mouse=

opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true

vim.diagnostic.config({
  virtual_text = false,
  update_in_insert = true,
  underline = true,
  float = {
    border = 'rounded',
    source = 'always',
  }
})
