function nixtest () {
    nix-build -E "(import <nixpkgs> {}).callPackage ./$1 {}"
}

function nixhest () {
    nix-build -E "(import <nixpkgs> {}).haskellPackages.callPackage ./$1 {}"
}
