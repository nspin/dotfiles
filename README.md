dotfiles
========

Various configuration files

#### Contents

*   **home**: Files to be linked to in ~  
*   **aux**: Files that files in 'core' refer to  
*   **rest**: Files that need to be installed manually  
*   **txt**: Non-source files  

#### Usage (assumes that this repo is in ~)

**Installation**:  
*   setup.sh creates symlinks from files in ~/dotfiles/home to ~, backing up old files in a directory called 'seliftod/(seconds since 1970)', unless the script is called with an argument  
*   pustes.sh removes symlinks in ~ with the same names as (*not* necessarily linking to) files in ~/dotfiles/home  

**Cabal-Hell**: My way of dealing with it is as follows:
*   Install GHC *only* (not the entire platform). For slackware, install 7.6 slackbuild, then build 7.10 from source.
*   Get cabal binary from haskell.org.
*   `cabal install cabal cabal-install alex happy`. These will be the *only* thing in .cabal/bin/
*   Discard old cabal binary.
*   *Only* work in sandboxes for specific projects.
*   Whenever you need Haskell stuff for your system (e.g. hlint) use the `beach` function from core/bashrcs. Binaries will have symlinks in ~/.beach/bin, which core/bash _ profile adds to `$PATH`.
*   Annoying exceptions: xmonad, yi, etc - programs that compile their own config files (which have expexted locations, which are not in sandboxes). If future releases of such programs cause dependancy hell among themselves, then this approach may have to be revised.

#### TODO

*   Keymap (both x and system, loadkeys emacs on slackware?)
*   Add xmobar to xmonad config
*   Use some sort of clipboard (parcellite)

> Notes:  
> *   Most snippets come from [honza/vim-snippets](https://www.github.com/honza/vim-snippets)
> *   I did not create the fonts in aux/fonts, [adobe](https://github.com/adobe-fonts/source-code-pro)
