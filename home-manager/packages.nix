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
    spotify
    tldr
    # rofi-wayland-unwrapped
    tree
    unzip
    xclip
    zip
    zotero
    (nerdfonts.override { fonts = [ "DejaVuSansMono" ]; })
  ];

}
