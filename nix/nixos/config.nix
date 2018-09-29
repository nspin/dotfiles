{ lib, ... }: {

  imports =
    let
      try = path: lib.optional (lib.pathExists path) path;
    in [
      ]
      ++ try (<local> + /config.nix)
      ++ try (<private> + /config.nix)
      ;

}
