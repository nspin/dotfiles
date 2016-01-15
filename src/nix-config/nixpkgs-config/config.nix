{ pkgs }:

{
  allowUnfree = true;

  haskellPackageOverrides = with pkgs.haskell.lib; self: super: {
  };

  packageOverrides = pkgs:
    let
      inherit (pkgs) callPackage;
    in
      with callPackage ./lib {};
      {
        fzf-tmux = callPackage ./local-pkgs/fzf-tmux {};
        mars = callPackage ./local-pkgs/mars {};
        ycm = callPackage ./local-pkgs/ycm {};

        mips-init = callHaskellScript ./misc-bin/mips-init {};
        hscript-test = callHaskellScript ./misc-bin/test {};
      };
}
