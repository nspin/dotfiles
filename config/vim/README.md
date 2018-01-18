# Vim Configuration

As a project, vim is well documented, stable, portable, etc.,
However, IMHO, the different components are jumbled together.
The best way to deal with this that I know of is to have
as much control as possible over the environment in which vim runs.

The runtime files that ship with vim (found in `/usr/share/vim/`) have a ton of stuff.
Vimscript files for language support,
plugins I never knew existed,
plugins that annoy me (e.g. netrw - it's over 11k lines of vimscript),
and more.

I've chosen those of these files that I do/may find useful,
and put them into a seperate repository.
I set `$VIM` to this directory and `$VIMRUNTIME` to wherever that repo lives
so that vim never sees anything in `/usr/share/vim`,
and I have full control over everything.

**Details**

*   `vimrc`...
    *   Carefully sets `rtp` with
        *   `pre/`
        *   External plugins (found in the directory specified by `$VIMBUNDLE`
            and as a list in `$MY_VIM_PLUGIN_PATH`)
        *   The stripped down runtime files
        *   External plugins' `after/` directories
        *   `post/`
    *   Sources additional configuration files from `lib/` and `init/` in alphabetical order
