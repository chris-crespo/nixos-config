{ config, pkgs, lib, ... }:
{
  programs.git = {
    enable = true;

    userName = "christian";
    userEmail = "christian.crespoo.98@gmail.com";

    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
