{ pkgs, ... }:
{
  home.packages = with pkgs; [
    brightnessctl
    fd
    feh
    firefox
    fzf
    killall
    libnotify
    ripgrep
    tldr
    tree
    (nerdfonts.override { fonts = [ "DejaVuSansMono" ]; })
  ];

}
