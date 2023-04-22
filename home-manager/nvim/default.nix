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
      cmp-nvim-lsp
      cmp-path
      cmp-buffer
      cmp-vsnip
      vim-vsnip
      neodev-nvim
      null-ls-nvim
      nvim-autopairs
      nvim-lspconfig
      nvim-surround
      {
        plugin = nvim-treesitter.withPlugins (p: with p; [ 
          astro 
          css
          nix 
          lua 
          rust 
          tsx
          typescript 
        ]);
      }
      nvim-tree-lua
      nvim-web-devicons
      haskell-tools-nvim
      rust-tools-nvim
      telescope-nvim
      yuck-vim
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
}
