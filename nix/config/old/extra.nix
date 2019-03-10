{ pkgs, lib, ... }: {

  programs.adb.enable = true;
  users.extraUsers.nick.extraGroups = ["adbusers"];

}
