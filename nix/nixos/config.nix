{ lib, ... }: {

  imports = [
    ./modules
    ./common
  ] ++ (lib.concatMap (path: lib.optional (lib.pathExists path) path) [
    (<local> + /config.nix)
    (<private> + /config.nix)
  ]);

}
