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

      xml-conduit
      html-conduit
      xml-lens
      dom-selector

      random
      cereal
      cereal-text
      ansi-wl-pprint

      diagrams

      http-client
      http-types

      cryptohash
      base16-bytestring
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

          my-ghc = pkgs.haskellPackages.ghcWithPackages ghcPackages;

          mars = callPackage ./local/mars {};

          ycm = callPackage ./local/ycm {};

          annoyingRtp = lib.vimRtpOf "annoying.rtp" [
            ycm
          ];
        };
      };
}
