self: super: with self; {

  lib = super.lib // (removeAttrs (callPackage ./lib {}) [ "override" "overrideDerivation" ]); # dancing with devil

  vim-plugins = callPackage ./vim-plugins {};
  inherit (callPackage ./dotfiles {}) mkDotfiles mkDotfilesIn update-dotfile-links;

  my-vim = callPackage ./pkgs/my-vim {
    inherit (darwin.apple_sdk.frameworks) CoreServices Cocoa Foundation CoreData;
    inherit (darwin) libobjc cf-private;
  };

  my-vim-gui = callPackage ./pkgs/my-vim {
    inherit (darwin.apple_sdk.frameworks) CoreServices Cocoa Foundation CoreData;
    inherit (darwin) libobjc cf-private;
    guiSupport = "auto";
  };

  uttyl = callPackage ./pkgs/uttyl {};
  fznode = callPackage ./pkgs/fznode {};
  readme-preview = callPackage ./pkgs/grip {};
  chicago95-theme = callPackage ./pkgs/chicago95-theme {};
  sddm-theme-abstractdark = callPackage ./pkgs/sddm-themes/abstractdark.nix {};

}
