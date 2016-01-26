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
      vim-plugins = callPackage ./local-pkgs/vim-plugins {};
      my-plugins = import ./aux/git-plugins.nix;
    in {
        local = rec {

          inherit lib;

          fzf-tmux = callPackage ./local-pkgs/fzf-tmux {};
          mars = callPackage ./local-pkgs/mars {};

          mips-init = lib.callHaskellScript ./misc-bin/mips-init {};

          my-ghc = pkgs.haskellPackages.ghcWithPackages ghcPackages;

          fzf-vim = callPackage ./local-pkgs/fzf-vim { inherit fzf-tmux; };
          ycm = callPackage ./local-pkgs/ycm {};

          vim-rtp = vim-plugins.rtpOf (
            [ ycm fzf-vim ] ++ map (str: builtins.getAttr str vim-plugins.gitPlugins) my-plugins
          );
        };
      };
}
