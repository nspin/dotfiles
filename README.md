dotfiles
========

Various configuration files

Contents
--------

**core**    Config files (~/.*file*) for use on my school's macs (vim, git, bash screen)
**extra**   Additional config files (~/.*file*) for use on my personal machine (X11, tmux)
**cetera**  Miscellaneous files that are not of the form ~/.*file*

Usage
_____

setup.sh acts on files from a specified dotfile directory (currently core and extras) to either:
    - Create symlinks to them as follows: ~/.*file*
    - Remove these symlinks
    - Backup the files that making symlinks would overwrite
    - Restore these backed-up files

> Note: Most snippets come from [honza/vim-snippets](https://www.github.com/honza/vim-snippets)
