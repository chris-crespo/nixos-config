local function map(mode, lhs, rhs)
  vim.api.nvim_set_keymap(mode, lhs, rhs, { noremap = true, silent = true })
end

vim.g.mapleader = ','

map('n', '<leader>t', '<cmd>NvimTreeToggle<cr>')
