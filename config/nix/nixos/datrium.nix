{ pkgs, ... }:

{
  imports = [
    ./common.nix
  ];

  environment.systemPackages = pkgs.mylib.gatherLists pkgs [
    ./lists/core.nix
    ./lists/huge.nix
    ./lists/current.nix
  ];

  boot.loader.grub.device = "/dev/sda";

  services.vmwareGuest.enable = true;

  boot.kernel.sysctl = {
    "kernel.core_pattern" = "|/da/ToolsAndLibs/CodingScripts/zipcore.sh %p %r %u %s";
    "kernel.core_pipe_limit" = 64;
  };
}
