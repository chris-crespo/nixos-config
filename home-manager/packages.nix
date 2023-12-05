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
    jq
    libnotify
    qmk
    ranger
    ripgrep
    spotify
    tldr
    tree
    unzip
    xclip
    zip
    (nerdfonts.override { fonts = [ "DejaVuSansMono" ]; })
  ];

}
