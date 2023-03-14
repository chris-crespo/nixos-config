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
      null-ls-nvim
      nvim-autopairs
      nvim-lspconfig
      nvim-surround
      {
        plugin = nvim-treesitter.withPlugins (p: [ p.nix p.lua p.rust ]);
      }
      nvim-tree-lua
      nvim-web-devicons
      rust-tools-nvim
      telescope-nvim
      yuck-vim
    ];

    extraPackages = with pkgs; [
      statix
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
