{ fetchgit, stdenv }:

{
  rtpOf = plugins: stdenv.mkDerivation {
    name = "rtp";
    builder = ./builder.sh;
    inherit plugins;
  };

  plugins =
    let
      raw = import ./plugins.nix;
      f =  name: {
        inherit name;
        value = fetchgit {
          url = "git://github.com/${name}";
          inherit (builtins.getAttr name raw) rev sha256;
        };
        /* } // builtins.getAttr name raw); */
      };
    in builtins.listToAttrs (map f (builtins.attrNames raw));
}
