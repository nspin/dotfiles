{ stdenv, fetchurl, fzf, fzf-tmux }:

stdenv.mkDerivation {
  name = "fzf-vim";
  builder = ./builder.sh;
  src = fetchurl {
    url = https://raw.githubusercontent.com/junegunn/fzf/0f281ef89410cd581b581fd6087e9edd1832d1e8/plugin/fzf.vim;
    sha256 = "0s54s1rh7443qrsm5z6gq577y9iyfddxzbpcq8ix32vlrlz0bcwa";
  };
  aPatch = ./a.patch;
  bPatch = ./b.patch;
  inherit fzf;
  fzfTmux = fzf-tmux; # does nix camelcasify these things?
}
