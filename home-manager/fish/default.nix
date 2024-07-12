
{ config, pkgs, lib, ... }:
{
  programs.fish = {
    enable = true;

    shellInit = ''
      if status is-login
        if test -z "$WAYLAND_DISPLAY" -a "$XDG_VTNR" = 1
          exec hyprland
        end
      end

      function fish_prompt
        set -l triangle_color (
          if test $status -ne 0
            echo '#f38ba8' 
          else
            echo '#a6e3a1'
          end
        )

        set -l path (
          if [ "$PWD" = "$HOME" ]
            echo '~'
          else
            echo (basename $PWD)
          end
        )

        printf '%s%s %s󱨊 ' (set_color '#89b4fa') $path (set_color "$triangle_color")
      end

      function fish_mode_prompt; end
      function fish_greeting; end
    '';

    shellAliases = {
      c = "clear";
      f = "set __file \$(fd --type f -H | fzf) && nvim $__file; set -e __file";
      d = "cd \$(fd --type d -H | fzf || pwd)";

      hm = "home-manager";
      dev = "nix develop";

      cp = "cp -r";
      mkdir = "mkdir -p";
      off = "poweroff";
      rm = "rm -r";

      "..." = "cd ../..";
      "...." = "cd ../../..";
      "....." = "cd ../../../..";
    };
  };
}
