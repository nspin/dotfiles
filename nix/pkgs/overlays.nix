# only for non-nixos

let
  try = path: self: super:
    if super.lib.pathExists path
    then import path self super
    else {};
in [
  (import ./overlay.nix)
  (try (<local> + /overlay.nix))
  (try (<private> + /overlay.nix))
]
