dotfiles
========

My personal configuration files for various tools and systems.

#### Contents

*   **`src/`**: All of my configuration files for everything
*   **`scripts/`**: Files and scripts for traditional dotfile-type configurations
    *   `setup.sh`: Does exactly what you'd expect with a stdin stream of *`relative/path/of/target/from/src`* *`/absolute/path/of/link/name`* pairs. Files of such pairs can be found in `scripts/` as well.
    *   `vimNixosSetup.sh` symlinks the output paths of certain nix-expressions the define vim plugins into `~/.nix-vim`
*   **`notes/`**: Files that aren't for computers
*   **`store/`**: Bits of files that will someday be useful

