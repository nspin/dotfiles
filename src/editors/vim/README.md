Vim Config
==========

As a project, vim is well documented, stable, portable, etc.,
However, imho, the different components are jumbled together.
The best way to deal with this that I know of is to have
as much control as possible over the environment in which vim runs.

The runtime files that ship with vim (found in `/usr/share/vim/`) have a ton of stuff.
Vimscript files for language support,
plugins I never knew existed,
plugins that annoy me (e.g. netrw - it's over 11k lines of vimscript),
and more.

I've chosen those of these files that I do/may find useful,
and put them into `~/vim-runtime/`
By setting `$VIM` to `./init/` and `$VIMRUNTIME` and to `~/vim-runtime` in my `.bashrc` (see `:h initialization`),
vim never sees anything in `/usr/share/vim`,
and I have full control over everything.

**More specifically, ...**

`./init/vimrc` sets `rtp` and sources stuff from `vimrc.d`

`./plugins` contains files of plugin names

`./scripts` contains scripts for things like installing plugins

`./vim.1` is has my own indent files, etc.
