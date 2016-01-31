{ pkgs, stdenv, haskellPackages }:

let

  callPackageWith = autoArgs: fn: args:
    let
      f = if builtins.isFunction fn then fn else import fn;
      auto = builtins.intersectAttrs (builtins.functionArgs f) autoArgs;
    in f (auto // args);

  callPackage = callPackageWith pkgs;

in rec {

  haskellScript = args:
    ({ name, src, libs, cpp ? {}, hp ? haskellPackages }:
      stdenv.mkDerivation {
        inherit name src;
        pkgdb = ghcPkgDB hp libs;
        ghcname = hp.ghc.name;
        builder = ./haskell-script-builder.sh;
        buildInputs = [ hp.ghc ];
        cppPairs = builtins.concatLists (map (attr: [attr (builtins.getAttr attr cpp)]) (builtins.attrNames cpp));
      }) (callPackage args {});

  ghcEnv = hp: pkgStrings: pkgs.myEnvFun {
    name = "ghc-env";
    buildInputs = map (str: builtins.getAttr str hp) pkgStrings;
  };

  ghcPkgDB = hp: pkgStrings: stdenv.mkDerivation {
    name = "ghc-package-db";
    inherit (hp) ghc;
    ghcname = hp.ghc.name;
    libraries = map (str: builtins.getAttr str hp) pkgStrings;
    builder = ./ghc-package-db-builder.sh;
  };

  vimRtpOf = outName: plugins: stdenv.mkDerivation {
    name = "vim-rtp";
    builder = ./vimrtp-builder.sh;
    inherit plugins outName;
  };

  txtToList = file:
    builtins.filter
      (str: builtins.stringLength str != 0 && builtins.substring 0 1 str != "#")
      (pkgs.lib.splitString "\n" (builtins.readFile file));

  flip = f: a: b: f b a;
}
