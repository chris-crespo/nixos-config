{ config, pkgs, lib, ... }:
{
  imports = [
    ./direnv
    ./dunst
    ./eww
    ./fish
    ./git
    ./gh
    ./hyprland
    ./keychain
    ./kitty
    ./nvim
    ./rofi

    ./packages.nix
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "chris";
  home.homeDirectory = "/home/nix";

  # home.pointerCursor = with pkgs; {
  #   # package = vanilla-dmz;
  #   # name = "Vanilla-DMZ";
  #   package = catppuccin-cursors.mochaMauve;
  #   name = "catppuccin-mocha-dark";
  #   size = 2;
  #   gtk.enable = true;
  #   x11.enable = true;
  # };

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

  nixpkgs.config.allowUnfree = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
