{ lib, stdenv, writeText, writeScript }:

{ assocs, target }:

stdenv.mkDerivation {
  name = "dotfiles";

  linkDotfiles = writeScript "link-dotfiles" ''
    #!${stdenv.shell}
    for nix_profile in $NIX_PROFILES; do
      dotfiles=$nix_profile/share/dotfiles
      if [ -d  $dotfiles ]; then
        ln -sfnv $dotfiles $HOME/.dotfiles
        pushd $dotfiles
          for dotfile in $(find . -not -type d); do
            mkdir -p $(dirname $HOME/$dotfile)
            ln -sfnv $HOME/.dotfiles/$dotfile $HOME/$dotfile
          done
        popd
        exit
      fi
    done
    echo "no profile contains dotfiles" >&2
    exit 1
  '';

  builder = writeText "builder.sh" ''
    . $stdenv/setup

    mkdir -p $out/bin
    ln -s $linkDotfiles $out/bin/link-dotfiles

    mkdir -p $out/share/dotfiles
    ${lib.concatMapStrings
        (name: ''
          mkdir -p $(dirname $out/share/dotfiles/${name})
          ln -s ${target}/${lib.getAttr name assocs} $out/share/dotfiles/${name}
        '')
        (lib.attrNames assocs)}
  '';

}
