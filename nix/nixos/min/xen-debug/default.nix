{ config, pkgs, ... }:

let

  xen-debug = pkgs.lib.overrideDerivation pkgs.xen (self: {
    patches = self.patches ++ [ ./xen-debug.patch ];
  });

in {

  environment.systemPackages = with pkgs; [
    xen-debug
  ];

  imports = [ 
    ../vbox
  ];

  virtualisation.xen.enable = true;
  virtualisation.xen.trace = true;
  virtualisation.xen.package = xen-debug;

}
