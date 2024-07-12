{ config, pkgs, ... }:
{
  home.file."${config.xdg.configHome}/rofi/".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/config/dotfiles/rofi/";
}
