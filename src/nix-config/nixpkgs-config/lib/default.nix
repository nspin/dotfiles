{ pkgs, stdenv, haskellPackages }:

let

  callPackageWith = autoArgs: fn: args:
    let
      f = if builtins.isFunction fn then fn else import fn;
      auto = builtins.intersectAttrs (builtins.functionArgs f) autoArgs;
    in f (auto // args);

  haskell-scripting = rec {

    callScript = fn: args: mkDerivation (callPackage fn args);

    callPackage = callPackageWith (pkgs // haskellPackages);

    mkDerivation = { name, src, libs, cpp ? {} }:
      stdenv.mkDerivation {
        inherit name src libs;
        ghcname = haskellPackages.ghc.name;
        builder = ./haskell-script-builder.sh;
        buildInputs = [ haskellPackages.ghc ];
        cppPairs = builtins.concatLists (map (attr: [attr (builtins.getAttr attr cpp)]) (builtins.attrNames cpp));
      };
    };

in {
  callHaskellScript = haskell-scripting.callScript;

  ghcEnv = hp: pkgStrings:
    pkgs.myEnvFun {
      name = "ghc-env";
      buildInputs = map (str: builtins.getAttr str hp) pkgStrings;
    };

  ghcPkgDB = hp: f: stdenv.mkDerivation {
      name = "ghc-package-db";
      inherit (hp) ghc;
      ghcname = hp.ghc.name;
      libraries = f hp;
      builder = ./ghc-package-db-builder.sh;
    }
  }
