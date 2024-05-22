{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, flake-utils, nixpkgs }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = (import nixpkgs) { inherit system; };
      in rec {
        # For `nix develop`:
        devShell = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [ 
            haskell-language-server
            cabal-install
            ghc
            haskellPackages.xmonad
            haskellPackages.xmonad-contrib
            haskellPackages.X11

            xorg.libX11
            xorg.libXrandr
            xorg.libXinerama
            xorg.libXScrnSaver
            xorg.libXext
          ];
        };
      }
    );
}


