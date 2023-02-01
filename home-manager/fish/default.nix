
{ config, pkgs, lib, ... }:
{
  programs.fish = {
    enable = true;

    #   function fish_prompt
    #     set -l path (basename $PWD)
    #     if test path = "nix" then
    #       echo "~ λ "
    #     else 
    #       echo "$path λ "
    #     end
    #   end
    shellInit = ''
      if status is-login
        if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
          exec startx -- -keeptty
        end
      end
    '';

    shellAliases = {
      c = "clear";
      f = "nvim \$(fd --type f -H | fzf)";
      d = "cd \$(fd --type d -H | fzf || pwd)";
      hm = "home-manager";

      cp = "cp -r";
      mkdir = "mkdir -p";
      off = "poweroff";
      rm = "rm -r";
    };
  };
}
