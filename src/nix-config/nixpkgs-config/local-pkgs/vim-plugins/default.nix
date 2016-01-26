{ fetchgit, stdenv }:

{
  rtpOf = plugins: stdenv.mkDerivation {
    name = "rtp";
    builder = ./builder.sh;
    inherit plugins;
  };

  gitPlugins =
    let
      raw = import ./git-plugins.nix;
      f =  name: {
        inherit name;
        value = fetchgit {
          url = "git://github.com/${name}";
          inherit (builtins.getAttr name raw) rev sha256;
        };
      };
    in builtins.listToAttrs (map f (builtins.attrNames raw));
}
