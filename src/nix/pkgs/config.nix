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

          lameRtp = lib.vimRtpOf "lame.rtp" (

            /* lame-vim-plugins."tpope/vim-repeat" */
            /* lame-vim-plugins."tpope/vim-surround" */
            /* lame-vim-plugins."tpope/vim-commentary" */
            /* lame-vim-plugins."guns/vim-sexp" */
            /* lame-vim-plugins."tpope/vim-sexp-mappings-for-regular-people" */
            /* lame-vim-plugins."godlygeek/tabular" */
            /* lame-vim-plugins."SirVer/ultisnips" */
            /* lame-vim-plugins."honza/vim-snippets" */
            /* lame-vim-plugins."tpope/vim-vinegar" */
            /* lame-vim-plugins."sjl/gundo.vim" */
            /* lame-vim-plugins."jpalardy/vim-slime" */
            /* lame-vim-plugins."vim-scripts/cscope_macros.vim" */
            /* lame-vim-plugins."nickspinale/vim-colors-solarized" */
          /* } */

            builtins.attrValues lame-vim-plugins.github

            /* map (lib.flip builtins.getAttr lame-vim-plugins.github) */
            /*     (lib.txtToList ../../vim-config/plugins/github.txt) */
          );
        };
      };
}
