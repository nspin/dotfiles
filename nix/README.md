```
let top = import ./.;
```

- `top.pkgs` is augmented with `<{local,private}/overlay.nix>`.
- `top.pkgs.env` is augmented with `paths` from `<{local,private}/env.nix>` (functions from `pkgs` to list of packages) and `pathsToLink` from `<{local,private}/env-paths-to-link.nix>`.
- `top.nixos` is **independently** augmented with `<{local,private}/overlay.nix>`.

`./path` contain top-level expressions for use in `NIX_PATH`.
