{ config, pkgs, ... }:
{
  # We only want to symblink the config to the dotfiles/hyprland folder,
  # so there's no need to enable hyprland here.

  home.packages = with pkgs; [
    hyprpaper
  ];

  home.file.".config/hypr/".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/config/dotfiles/hypr/";
}
