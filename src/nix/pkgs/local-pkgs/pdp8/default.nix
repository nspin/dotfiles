{ stdenv }:

stdenv.mkDerivation {
    name = "pdp8";
    builder = ./builder.sh;
    src = ./src;
}
