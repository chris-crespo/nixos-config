require'conform'.setup({
  formatters_by_ft = {
    typescript = { { "prettier" } },
    typescriptreact = { { "prettier" } },
  },
})
