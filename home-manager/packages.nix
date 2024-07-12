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
    nix-du
    # qmk
    ranger
    ripgrep
    rofi-wayland-unwrapped
    spotify
    tldr
    tree
    unzip
    xclip
    zip
    zotero
    (nerdfonts.override { fonts = [ "DejaVuSansMono" ]; })
  ];

}
