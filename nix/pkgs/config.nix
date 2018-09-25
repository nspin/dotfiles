{ pkgs }: {

  allowUnfree = true;
  allowBroken = true;

  # pulseaudio = true;
  # firefox.enableAdobeFlash = true;
  # chromium.enablePepperFlash = true;

  packageOverrides = import ./overrides.nix;

}
