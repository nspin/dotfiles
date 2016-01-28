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

          fzf-tmux = callPackage ./local-pkgs/fzf-tmux {};
          mars = callPackage ./local-pkgs/mars {};
          pdp8 = callPackage ./local-pkgs/pdp8 {};

          mips-init = lib.callHaskellScript ./misc-bin/mips-init {};

          my-ghc = pkgs.haskellPackages.ghcWithPackages ghcPackages;

          fzf-vim = callPackage ./local-pkgs/fzf-vim { inherit fzf-tmux; };
          ycm = callPackage ./local-pkgs/ycm {};

          lame-vim-plugins = callPackage ./local-pkgs/lame-vim-plugins {};

          annoyingRtp = lib.vimRtpOf "annoying.rtp" [ ycm fzf-vim ];
          lameRtp = lib.vimRtpOf "lame.rtp" (
            builtins.attrValues lame-vim-plugins.github
            /* map (lib.flip builtins.getAttr lame-vim-plugins.github) */
            /*     (lib.txtToList ../../vim-config/plugins/github.txt) */
          );
        };
      };
}
