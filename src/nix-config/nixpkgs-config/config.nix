{ pkgs }:

let
  ghcPackages = hp: with hp;
    [ attoparsec
      aeson
      wreq
      async
      pipes
      pipes-bytestring
      pipes-parse
      pipes-attoparsec
      lens
      free
      mtl
      network
      optparse-applicative
      stm
      vector
    ];

in {
  allowUnfree = true;

  haskellPackageOverrides = with pkgs.haskell.lib; self: super: {
  };

  packageOverrides = pkgs:
    let
      inherit (pkgs) callPackage;
      lib = callPackage ./lib {};
    in {
        local = rec {

          inherit lib;

          fzf-tmux = callPackage ./local-pkgs/fzf-tmux {};
          fzf-vim = callPackage ./local-pkgs/fzf-vim { inherit fzf-tmux; };
          mars = callPackage ./local-pkgs/mars {};
          ycm = callPackage ./local-pkgs/ycm {};

          mips-init = lib.callHaskellScript ./misc-bin/mips-init {};

          my-ghc = pkgs.haskellPackages.ghcWithPackages ghcPackages;
        };
      };
}
