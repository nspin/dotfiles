{ stdenv }:

/* Create a file in $out/share/vim-plugins with:
 *  - outName: name of file
 *  - plugins: list of names of derivations containing actual plugins
 */

outName: plugins: stdenv.mkDerivation {
  name = "vim-rtp";
  builder = ./builder.sh;
  inherit plugins outName;
}

