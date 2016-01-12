dotfiles
========

My personal configuration files for various tools and systems.

#### Contents

*   **`src`**: All of my configuration files for everything
*   **`scripts`**: Files and scripts for traditional dotfile-type configurations
    *   `setup.sh`: Creates the symlinks links specified by a stream of source-target pairs from stdin in the following format:

        `relative/path/of/target/from/src /absolute/path/of/link/name`
*   **`notes`**: Files that aren't for computers
*   **`store`**: Bits of files that will someday be useful

#### Annoying Things

*   To build YouCompleteMe's `third_party` stuff on nixos, run `scripts/vimNixosSetup.sh`
