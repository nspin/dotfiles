{ pkgs, ... }:

{
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "nick" ];
}
