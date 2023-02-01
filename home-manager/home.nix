{ config, pkgs, lib, ... }:
{
  imports = [
    # ../dunst
    # ../eww
    ./fish
    ./kitty
    ./nvim
    # ../picom
    ./rofi
    ./xmonad

    ./git
    ./packages.nix
    ./xinitrc.nix
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "chris";
  home.homeDirectory = "/home/nix";

  home.pointerCursor = with pkgs; {
    package = catppuccin-cursors.mochaDark;
    name = "Catppuccin-Mocha-Dark-Cursors";
    x11 = {
      enable = true;
    }; 
  };

  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    sshKeys = [
      "0C85337D46761F33E9B2B99B41E6DDFFE4FF7C99"
    ];
  };

  fonts.fontconfig.enable = true;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager rel ease introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

}
