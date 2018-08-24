{ lib, stdenv, writeText }:

{ target, assocs }:

stdenv.mkDerivation {
  name = "hdir";

  makeLinks = builtins.toFile "makeLinks" ''
    cd @here@
    for x in $(find . -not -type d); do
      ln -sfnv @here@/$x $HOME/$x
    done
  '';

  builder = writeText "builder.sh" ''
    . $stdenv/setup

    mkdir -p $out/bin
    export here=$out/share/hdir
    substituteAll $makeLinks $out/bin/hdir-link
    chmod +x $out/bin/hdir-link

    mkdir -p $out/share/hdir
    ${lib.concatMapStrings
        (name: ''
          mkdir -p "$(dirname "$out/share/hdir/${name}")"
          ln -s ${target}/${lib.getAttr name assocs} $out/share/hdir/${name}
        '')
        (lib.attrNames assocs)}
  '';

}
