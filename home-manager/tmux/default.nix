{ config, pkgs, lib, ... }:
{
  programs.tmux = {
    enable = true;
  };

  xdg.configFile."tmux/tmux.conf".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/config/dotfiles/tmux/tmux.conf";
}
