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
    tldr
    tree
    unzip
    xclip
    zip
    (nerdfonts.override { fonts = [ "DejaVuSansMono" ]; })
  ];

}
