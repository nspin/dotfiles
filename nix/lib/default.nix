self: super: with self;

{

  compose = f: g: x: f (g x);

  nixPathAttrs = listToAttrs (map ({ prefix, path }: { name = prefix; value = path; }) builtins.nixPath);

  makeOverridableWith = f: g: x: (g x) // {
    override = x': makeOverridableWith f g (f x' x);
  };

  optionalPath = suffix: base: optionals (hasAttr base nixPathAttrs) (
    let path = builtins.toPath (nixPathAttrs.${base} + suffix);
    in optional (pathExists path) path
  );

  extantPaths = compose concatMap optionalPath;

  tryImports = suffix: bases: map import (concatMap (optionalPath suffix) bases);

  # TODO
  composeOverlays = overlays: foldl' (lib.flip lib.extends) something;

}
