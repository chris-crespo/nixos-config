{ pkgs, ... }:
{
  home.packages = with pkgs; [
    eww
  ];

  home.file.".config/eww/eww.yuck".source = ./eww.yuck;
  home.file.".config/eww/eww.scss".source = ./eww.scss;
}
