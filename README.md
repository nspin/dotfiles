dotfiles
========

My personal configuration files for various tools and systems.

#### Contents

*   **`homedir`**: Files and scripts for traditional dotfile-type configurations.
    *   `setup.sh`: Creates `.`-prefixed symlinks in `~` to files in `core`, backing up old files/links that would be replaces in a directory called `~/seliftod/`*seconds since 1970*, unless the script is called with an argument
    *   `putes.sh`: Removes files and symlinks in `~` with the same names as *(but not necessarily linking to*) files in `core`
    *   **`core`**: Files to be directly linked from `~`
    *   **`aux`**: Auxilary files, referred to by those in `core`
*   **`nix-config`**: Nix expressions to be imported by `configuration.nix`
*   **`misc`**: Miscellaneous configuration files with no uniform means of installation
*   **`notes`**: Files that aren't for computers

> Most snippets come from [honza/vim-snippets](https://www.github.com/honza/vim-snippets)  
> The fonts that once existed in aux/fonts were created by [adobe](https://github.com/adobe-fonts/source-code-pro)
