local cmp = require'cmp'
local luasnip = require'luasnip'

cmp.setup {
  snipeet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },
  completion = {
    keyword_length = 2
  },
  mapping = {
    ['<Tab>'] = cmp.mapping.confirm { select = true },
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
    { name = 'buffer' }
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered()
  }
}
