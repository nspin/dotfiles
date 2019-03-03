{ lib }:

with lib;

rec {

  nixPathAttrs = listToAttrs (map ({ prefix, path }: { name = prefix; value = path; }) builtins.nixPath);

}
