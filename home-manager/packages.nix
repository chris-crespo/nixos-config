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
    unzip
    xclip
    zip
    (nerdfonts.override { fonts = [ "DejaVuSansMono" ]; })
  ];

}
