dotfiles
========

My personal configuration files for various tools and systems.

Note that larger bodies of config files (e.g. those for vim and nix) are located in their own repositories.

#### Contents

*   **`src/`**: All of my configuration files for everything, with a few vim-related exceptions (see `src/editors/vim` for more info)
*   **`scripts/`**: Files and scripts for traditional dotfile-type configurations
    *   `setup.sh`: Does exactly what you'd expect with a stdin stream of *`relative/path/of/target/from/src`* *`/absolute/path/of/link/name`* pairs. Files of such pairs can be found in `scripts/` as well.
*   **`notes/`**: Files that aren't for computers
*   **`store/`**: Pieces of files that may someday be useful
