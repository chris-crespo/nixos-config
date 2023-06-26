{ config, pkgs, lib, ... }:
{
  programs.git = {
    enable = true;

    userName = "Christian Crespo";
    userEmail = "christian.crespoo.98@gmail.com";

    aliases = {
      pub = "push -u origin HEAD";
      cm = "commit";
    };

    extraConfig = {
      init.defaultBranch = "main";
    };

    includes = [
      {
        path = "~/work/.gitconfig";
        condition = "gitdir:~/work/";
      }
    ];
  };
}
