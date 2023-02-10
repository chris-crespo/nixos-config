{ pkgs, ... }:
{
  services.picom = {
    enable = true;

    package = pkgs.picom.overrideAttrs (_: {
      src = pkgs.fetchFromGitHub {
        repo = "picom";
        owner = "ibhagwan";
        rev = "44b4970f70d6b23759a61a2b94d9bfb4351b41b1";
        sha256 = "0iff4bwpc00xbjad0m000midslgx12aihs33mdvfckr75r114ylh";
      };
    });

    backend = "glx";

    shadow = true;
    shadowOffsets = [ 2 2 ];
    shadowOpacity = 0.95;
    settings = { 
      corner-radius = 2;
      round-borders = 2;
      full-shadow = true;
      shadow-radius = 2;
      shadow-exclude = [
        "window_type = 'menu'"
        "window_type = 'dropdown_menu'"
        "window_type = 'popup_menu'"
        "window_type = 'tooltip'"
        "window_type = 'utility'"
      ];
    };
  };
}
