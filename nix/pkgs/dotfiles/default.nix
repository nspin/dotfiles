{ lib, stdenv, writeText, writeScript }:

{ assocs, target }:

stdenv.mkDerivation {
  name = "dotfiles";

  update = writeScript "update-dotfile-links" ''
    #!${stdenv.shell}
    sh ${./update-dotfile-links.sh}
  '';

  builder = writeText "builder.sh" ''
    . $stdenv/setup

    mkdir -p $out/bin
    ln -s $update $out/bin/update-dotfile-links

    mkdir -p $out/share/dotfiles
    ${lib.concatMapStrings
        (name: ''
          mkdir -p $(dirname $out/share/dotfiles/${name})
          ln -s ${target}/${lib.getAttr name assocs} $out/share/dotfiles/${name}
        '')
        (lib.attrNames assocs)}
  '';

}
