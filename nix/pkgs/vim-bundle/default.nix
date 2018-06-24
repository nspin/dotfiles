{ lib, stdenv, fetchgit }:

let
  zipNames = names: values: with lib;
    listToAttrs (zipListsWith nameValuePair names values);
  plugins =
    builtins.map
      (line: fetchgit (zipNames ["url" "rev"] (lib.splitString " " line)))
      (builtins.filter
        (line: builtins.stringLength line != 0 && builtins.substring 0 1 line != "#")
        (lib.splitString "\n" (builtins.readFile ./refs.txt)));
in stdenv.mkDerivation {
  name = "vim-bundle";
  builder = ./builder.sh;
}
