-- if first install or if `lazypath` just does not exist,
-- manually run `git clone --filter=blob:none https://github.com/folke/lazy.nvim.git --branch=stable <lazypath>`
-- instead of using the recommended way, as it may not work
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
vim.opt.rtp:prepend(lazypath)

require'lazy'.setup {
  'folke/neodev.nvim',
  { "catppuccin/nvim", name = "catppuccin", lazy = false },
  { 'tpope/vim-fugitive' },
  {
    'stevearc/oil.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
    -- use opts = {} for passing setup options
    -- this is equalent to setup({}) function
  },
  { 'neovim/nvim-lspconfig' },
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
  { 'nvim-treesitter/nvim-treesitter-textobjects' },
  { 'neovim/nvim-lspconfig' },
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
  },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'saadparwaiz1/cmp_luasnip',
    },
  },
  {
    'mrcjkb/haskell-tools.nvim',
    lazy = false, -- This plugin is already lazy
  },
  {
    'mrcjkb/rustaceanvim',
    lazy = false, -- This plugin is already lazy
  },
  { "pmizio/typescript-tools.nvim" },
  { 'stevearc/conform.nvim' },
  { dir = '/home/nix/starbux/client', lazy = false }
}
