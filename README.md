dotfiles
========

Various configuration files

#### Contents

*   **core**: Files to be linked to in ~  
	*   **base**: Config files (~/.*file*) for use on my school's macs (vim, git, bash screen)  
	*   **extra**: Additional config files (~/.*file*) for use on my personal machine (X11, tmux)  
*   **aux**: Files that files in 'core' refer to  
*   **rest**: Files that need to be installed manually  
*   **nosrc**: Non-source files  

#### Usage

**setup.sh**: Acts on files from a specified subdirectories of 'core' according to one of four choices:  
*   Create symlinks to them (e.g. ~/.*file*)
*   Remove these symlinks  
*   Backup the files that making symlinks would overwrite  
*   Restore these backed-up files  

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

> Note: Most snippets come from [honza/vim-snippets](https://www.github.com/honza/vim-snippets)
