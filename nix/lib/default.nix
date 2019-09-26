self: super: with self;

{

  compose = f: g: x: f (g x);

  makeOverridableWith = f: g: x: (g x) // {
    override = x': makeOverridableWith f g (f x' x);
  };

  # NOTE: In case of repeat 'name', builtins.nixPath keeps first 'value'
  nixPathAttrs = listToAttrs (map ({ prefix, path }: { name = prefix; value = path; }) builtins.nixPath);

}
