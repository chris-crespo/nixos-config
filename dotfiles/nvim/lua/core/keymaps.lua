vim.g.mapleader = ','

local function opts(extra)
  local base = { noremap = true, ssilent = true }
  vim.tbl_extend('force', base, extra or {})
end

vim.keymap.set('n', '<leader>r', ':so %<CR>', opts())

-- Oil
vim.keymap.set('n', '-', ':Oil<CR>', opts({ desc = 'Open parent directory' }))

-- Telescope
local builtin = require'telescope.builtin'
vim.keymap.set('n', '<leader>fd', builtin.diagnostics)
vim.keymap.set('n', '<leader>ff', builtin.find_files)
vim.keymap.set('n', '<leader>fg', builtin.live_grep)
vim.keymap.set('n', '<leader>fr', builtin.lsp_references)
vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols)
