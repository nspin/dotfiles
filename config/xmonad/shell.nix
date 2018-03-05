with import <nixpkgs> {}; stdenv.mkDerivation {
  name = "env";
  buildInputs = [
    (haskellPackages.ghcWithPackages (hp: with hp; [
      xmonad
      xmonad-contrib
      xmonad-extras
    ]))
  ];
}
