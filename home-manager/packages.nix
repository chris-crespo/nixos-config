{ pkgs, ... }:
{
  home.packages = with pkgs; [
    brightnessctl
    fd
    feh
    firefox
    fzf
    killall
    httpie
    libnotify
    ranger
    ripgrep
    tldr
    tree
    xclip
    (nerdfonts.override { fonts = [ "DejaVuSansMono" ]; })
  ];

}
