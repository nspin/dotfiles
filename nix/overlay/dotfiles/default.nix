{ lib, runCommand, writeShellScriptBin, coreutils, findutils }:

with lib;

rec {

  update-dotfile-links = writeShellScriptBin "update-dotfile-links" ''
    set -e
    export PATH=${coreutils}/bin:${findutils}/bin
    . ${./update-dotfile-links.sh}
  '';

  mkDotfilesIn = src_base: links: mkDotfiles (mapAttrs (dst_rel: src_rel: "${src_base}/${src_rel}") links);

  mkDotfiles = links: runCommand "dotfiles" {} ''
    dst_base=$out/share/dotfiles
    mkdir -p $dst_base
    ${concatStrings (mapAttrsToList (dst_rel: src: ''
      dst="$dst_base/${dst_rel}"
      mkdir -p "$(dirname "$dst")"
      ln -s ${src} $dst
    '') links)}
  '';

}
