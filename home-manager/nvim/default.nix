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
      nvim-autopairs
      nvim-cmp
      nvim-surround
      {
        plugin = nvim-treesitter.withPlugins (p: [ p.nix p.lua ]);
      }
      nvim-tree-lua
      nvim-web-devicons
      telescope-nvim
      yuck-vim
    ];

    extraPackages = with pkgs; [
      statix
    ];

    extraConfig = with builtins; ''
      lua <<EOF
        ${builtins.readFile ./init.lua}
        ${builtins.readFile ./lua/core/keymaps.lua}
        ${pluginConfigs}
      EOF
    '';
  };

  # home.file.".config/nvim/init.lua".source = ./init.lua;
}
