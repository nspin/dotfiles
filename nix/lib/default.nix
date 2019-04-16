{ lib }:

with lib;

rec {

  nixPathAttrs = listToAttrs (map ({ prefix, path }: { name = prefix; value = path; }) builtins.nixPath);

  makeOverridableWith = f: g: x: (g x) // {
    override = x': makeOverridableWith f g (f x' x);
  };

  optionalPath = suffix: base: optionals (hasAttr base nixPathAttrs) (
    let path = builtins.toPath (nixPathAttrs.${base} + suffix);
    in optional (pathExists path) path
  );

}
