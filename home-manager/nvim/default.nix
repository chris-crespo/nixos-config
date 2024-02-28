{ config, pkgs, lib, ... }: let
  pluginDir = ./lua/plugins;

  pluginConfigs = with builtins;let
    files = attrNames (readDir pluginDir);
    contents = map (file: readFile "${pluginDir}/${file}") files;
  in concatStringsSep "\n" contents;
in {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      catppuccin-nvim
      nvim-cmp
      comment-nvim
      cmp-nvim-lsp
      cmp-path
      cmp-buffer
      cmp-vsnip
      vim-vsnip
      vim-fugitive
      neodev-nvim
      null-ls-nvim
      nvim-autopairs
      nvim-lspconfig
      nvim-surround
      {
        plugin = nvim-treesitter.withPlugins (p: with p; [ 
          astro 
          css
          fish
          html
          java
          nix 
          lua 
          prisma
          rust 
          tsx
          typescript 
        ]);
      }
      nvim-ts-autotag
      nvim-web-devicons
      rustaceanvim
      telescope-nvim
      yuck-vim

      nvim-jdtls
    ];

    extraPackages = with pkgs; [
      statix
      sumneko-lua-language-server
    ];

    extraConfig = with builtins; ''
lua <<EOF
${builtins.readFile ./init.lua}
${builtins.readFile ./lua/opts.lua}
${builtins.readFile ./lua/core/keymaps.lua}
${pluginConfigs}
EOF
    '';
  };

  home.file.".config/nvim/ftplugin/java.lua".text = ''
    local function on_attach(client, buffer)
      local opts = { buffer = buffer }
      vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, opts)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
      vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
      vim.keymap.set('n', 'F', vim.lsp.buf.format, opts)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
      vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    end

    local cmd = os.getenv('JDTLS_PATH')
    local config = {
      on_attach = on_attach,
      cmd = { cmd, '-data', '/home/nix/.cache/jdtls/workspace/'},
      root_dir = vim.fs.dirname(vim.fs.find({'.git', 'mvnw'}, { upward = true })[1]),
    }

    require('jdtls').start_or_attach(config)
  '';
}
