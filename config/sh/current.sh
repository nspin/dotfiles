function nixtest () {
    nix-build -E "(import <nixpkgs> {}).callPackage $1 {}"
}
