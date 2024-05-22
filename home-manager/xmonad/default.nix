{ config, ... }:
{
  xsession.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
  };

  home.file.".xmonad/xmonad.hs".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/config/dotfiles/xmonad/xmonad.hs";
}
