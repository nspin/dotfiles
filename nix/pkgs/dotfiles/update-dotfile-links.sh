set -e

add_links() {
    src=$1
    dst=$2
    verbose=$3
    command pushd $src &>/dev/null
        for leaf in $(find . -type f -o -type l | sed 's|^./||'); do
            if [ -L $dst/$leaf -a "$(readlink $dst/$leaf)" == "$src/$leaf" ]; then
                :
            elif [ -e $dst/$leaf -o -L $dst/$leaf ]; then # handles broken symlinks
                [ -n "$verbose" ] && echo "warning: $leaf already exists in $dst" >&2
            else
                mkdir -p $(dirname $dst/$leaf)
                extra_ln_flags=
                [ -n "$verbose" ] && extra_ln_flags="-v $extra_ln_flags"
                ln -sn $extra_ln_flags $src/$leaf $dst/$leaf
            fi
        done
    command popd &>/dev/null
}

tmp="$(mktemp -d)"

for nix_profile in $NIX_PROFILES; do
    dotfiles=$nix_profile/share/dotfiles
    if [ -d $dotfiles ]; then
        add_links $dotfiles $tmp
    fi
done

aggregate="$HOME/.dotfiles"
[ -d $aggregate ] && rm -r $aggregate
mv $tmp $aggregate

add_links $aggregate $HOME 1
