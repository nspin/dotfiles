{ nixpkgs ? import <nixpkgs> {}, compiler ? "default" }:

(if compiler == "default"
     then nixpkgs.pkgs.haskellPackages
     else nixpkgs.pkgs.haskell.packages.${compiler}).override {
  overrides = self: super: {
      mod-n = self.callPackage ./mod-n {};
      bigword = self.callPackage ./bigword {};
      bencode = self.callPackage ./bencode {};
      aether = self.callPackage ./aether {};
    };
}
