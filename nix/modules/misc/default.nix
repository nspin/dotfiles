{ ... }:

{

  imports = [
    ./zerofree.nix
  ];

  nix.extraOptions = ''
    gc-keep-outputs = true
    gc-keep-derivations = true
  '';

}
