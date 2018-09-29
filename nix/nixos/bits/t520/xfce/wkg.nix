{ config, lib, pkgs, ... }:

with lib;

let

  dmcfg = config.services.xserver.displayManager;
  ldmcfg = dmcfg.lightdm;

  inherit (pkgs) stdenv lightdm writeScript writeText;

  theme = pkgs.lightdm_webkit2_greeter;
  icons = pkgs.lightdm_webkit2_greeter;

  # The default greeter provided with this expression is the GTK greeter.
  # Again, we need a few things in the environment for the greeter to run with
  # fonts/icons.

  # wrappedWebkitGreeter = pkgs.runCommand "lightdm-webkit2-greeter"
  #   { buildInputs = [ pkgs.makeWrapper ]; }
  #   ''
  #     # This wrapper ensures that we actually get themes
  #     makeWrapper ${pkgs.lightdm_webkit2_greeter}/bin/lightdm-webkit2-greeter \
  #       $out/greeter \
  #       --prefix PATH : "${pkgs.glibc.bin}/bin" \
  #       --set GDK_PIXBUF_MODULE_FILE "${pkgs.gdk_pixbuf.out}/lib/gdk-pixbuf-2.0/2.10.0/loaders.cache" \
  #       --set GTK_PATH "${theme}:${pkgs.gtk3.out}" \
  #       --set GTK_EXE_PREFIX "${theme}" \
  #       --set GTK_DATA_PREFIX "${theme}" \
  #       --set XDG_DATA_DIRS "${theme}/share:${icons}/share" \
  #       --set XDG_CONFIG_HOME "${theme}/share"
  #     cat - > $out/lightdm-webkit2-greeter.desktop << EOF
  #     [Desktop Entry]
  #     Name=LightDM Greeter
  #     Comment=This runs the LightDM Greeter
  #     Exec=$out/greeter
  #     Type=Application
  #     EOF
  #   '';

  wrappedWebkitGreeter = pkgs.runCommand "lightdm-webkit2-greeter"
    { buildInputs = [ pkgs.makeWrapper ]; }
    ''
      mkdir $out
      cp ${pkgs.lightdm_webkit2_greeter}/bin/lightdm-webkit2-greeter \
        $out/greeter \

      cat - > $out/lightdm-webkit2-greeter.desktop << EOF
      [Desktop Entry]
      Name=LightDM Greeter
      Comment=This runs the LightDM Greeter
      Exec=$out/greeter
      Type=Application
      EOF
    '';

  webkit2GreeterConf = writeText "lightdm-webkit2-greeter.conf"
    ''
    [greeter]
    webkit-theme=default
    '';

  foo = stdenv.mkDerivation {
    name = "foo";
    builder = writeText "builder.sh" ''
      . $stdenv/setup
      cp ${pkgs.lightdm_webkit2_greeter}/etc/lightdm/*.conf $out
    '';
  };

in
{

  environment.etc."foobar".source = wrappedWebkitGreeter;

  services.xserver.displayManager.lightdm.greeter = mkDefault {
    package = wrappedWebkitGreeter;
    name = "lightdm-webkit2-greeter";
  };

  environment.etc."lightdm/lightdm-webkit2-greeter.conf".source = webkit2GreeterConf;
  # environment.etc."lightdm/lightdm-webkit2-greeter.conf".source = foo;

}
