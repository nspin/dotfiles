{ nixpkgs ? import <nixpkgs> {}, compiler ? "default" }:

with import /home/nick/.nix-defexpr/channels_root/nixos/pkgs/development/haskell-modules/lib.nix { pkgs = nixpkgs; };

(if compiler == "default"
     then nixpkgs.pkgs.haskellPackages
     else nixpkgs.pkgs.haskell.packages.${compiler}).override {
  overrides = self: super: {
      mod-n = self.callPackage ./mod-n {};
      bigword = dontCheck (self.callPackage ./bigword {});
      # bigword = self.callPackage ./bigword {};
      bencode = self.callPackage ./bencode {};
      aether = self.callPackage ./aether {};
      data-type-util = self.callPackage ./data-type-util {};
    };
}
