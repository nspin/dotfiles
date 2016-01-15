{ stdenv, fetchurl, fzf, tmux }:

stdenv.mkDerivation {
  name = "fzf-tmux";
  builder = ./builder.sh;
  patch = ./fzfbin.patch;
  src = fetchurl {
    url = https://raw.githubusercontent.com/junegunn/fzf/0f281ef89410cd581b581fd6087e9edd1832d1e8/bin/fzf-tmux;
    sha256 = "1g12hn74jnpnm1pwkilci2mfazjsmhysv97i06qmnhfn2c24wlfj";
  };
  inherit fzf tmux;
}
