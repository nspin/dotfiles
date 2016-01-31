{ fetchgit, stdenv }:

{
  github =
    let
      raw = import ./plugins/github.nix;
      f =  name: {
        inherit name;
        value = fetchgit {
          url = "git://github.com/${name}";
          inherit (builtins.getAttr name raw) rev sha256;
        };
      };
    in builtins.listToAttrs (map f (builtins.attrNames raw));
}
