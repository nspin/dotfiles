{ pkgs }:

{
  allowUnfree = true;
  allowBroken = true;

  haskellPackageOverrides = with pkgs.haskell.lib; self: super: {
  };

  packageOverrides = pkgs:
    let
      inherit (pkgs) callPackage;
    in with callPackage ./lib {}; {
        local = rec {

          fzf-tmux = callPackage ./local-pkgs/fzf-tmux {};
          fzf-vim = callPackage ./local-pkgs/fzf-vim { inherit fzf-tmux; };
          mars = callPackage ./local-pkgs/mars {};
          ycm = callPackage ./local-pkgs/ycm {};

          mips-init = callHaskellScript ./misc-bin/mips-init {};

        };
      };
}
