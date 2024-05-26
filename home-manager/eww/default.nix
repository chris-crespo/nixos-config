{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    eww
  ];

  home.file.".config/eww/".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/config/dotfiles/eww/";
}
