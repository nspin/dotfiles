{ pkgs, stdenv, haskellPackages }:

let

  callPackageWith = autoArgs: fn: args:
    let
      f = if builtins.isFunction fn then fn else import fn;
      auto = builtins.intersectAttrs (builtins.functionArgs f) autoArgs;
    in f (auto // args);

  callPackage = callPackageWith pkgs;

in rec {

  gatherLists = x: ls: builtins.concatLists (map (l: import l x) ls);

  # ghcEnv = hp: pkgStrings: pkgs.myEnvFun {
  #   name = "ghc-env";
  #   buildInputs = map (str: builtins.getAttr str hp) pkgStrings;
  # };

  txtToList = file:
    builtins.filter
      (str: builtins.stringLength str != 0 && builtins.substring 0 1 str != "#")
      (pkgs.lib.splitString "\n" (builtins.readFile file));

  flip = f: a: b: f b a;

}
