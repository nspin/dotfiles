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
      containers
      taggy-lens
      bytestring
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
          inherit ghcPackages;

          fzf-tmux = callPackage ./local/fzf-tmux {};
          mars = callPackage ./local/mars {};

          my-ghc = pkgs.haskellPackages.ghcWithPackages ghcPackages;

          fzf-vim = callPackage ./local/fzf-vim { inherit fzf-tmux; };
          ycm = callPackage ./local/ycm {};

          lame-vim-plugins = callPackage ./local/lame-vim-plugins {};

          annoyingRtp = lib.vimRtpOf "annoying.rtp" [
            ycm
            fzf-vim
          ];
        };
      };
}
