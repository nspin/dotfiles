dotfiles
========

My personal configuration files for various tools and systems.

#### Contents

*   **`src`**: All of my configuration files for everything
*   **`scripts`**: Files and scripts for traditional dotfile-type configurations
    *   `setup.sh`: Creates the symlinks links specified by stdin in the following format:

        `relative/path/of/target/from/src /absolute/path/of/link/name`
*   **`notes`**: Files that aren't for computers

#### Annoying Things

*   To build YouCompleteMe's third_party stuff on nixos, run scripts/vimNixosSetup.sh, and make sure that nixpkgs.pkgs.python27 is in the user environment.
