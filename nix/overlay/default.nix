self: super: with self; {

  inherit (callPackage ./vim-plugins {}) vim-plugins vim-plugins-all vim-plugins-excluding;
  inherit (callPackage ./dotfiles {}) mkDotfiles mkDotfilesIn update-dotfile-links;

  my-vim = callPackage ./pkgs/vim {
    inherit (darwin.apple_sdk.frameworks) CoreServices Cocoa Foundation CoreData;
    inherit (darwin) libobjc cf-private;
  };

  my-vim-gui = callPackage ./pkgs/vim {
    inherit (darwin.apple_sdk.frameworks) CoreServices Cocoa Foundation CoreData;
    inherit (darwin) libobjc cf-private;
    guiSupport = "auto";
  };

  uttyl = callPackage ./pkgs/uttyl {};
  fznode = callPackage ./pkgs/fznode {};
  readme-preview = callPackage ./pkgs/grip {};
  chicago95-theme = callPackage ./pkgs/chicago95-theme {};
  sddm-theme-abstractdark = callPackage ./pkgs/sddm-themes/abstractdark.nix {};

  extra-sourceview-color-schemes = callPackage ./pkgs/extra-sourceview-color-schemes {};

  # WIP

  autopsy = callPackage ./pkgs/autopsy {
    sleuthkit = sleuthkit.override {
      javaBindings = true;
    };
  };

}
