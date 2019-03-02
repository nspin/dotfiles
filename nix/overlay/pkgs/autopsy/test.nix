with import <nixpkgs> {};
callPackages ./. {
  sleuthkit = sleuthkit.override {
    javaBindings = true;
  };
}
