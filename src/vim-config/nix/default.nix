{ nixpkgs ? import <nixpkgs> {} }:

with nixpkgs;

{
  ycm = callPackage (import ./ycm) {};
}
