tmp=$(mktemp -d)

for nix_profile in $NIX_PROFILES; do
    src=$tmp
    dst=$nix_profile/share/dotfiles
    if [ -d $dst ]; then
        for leaf in $(find $dst/ -not -type d -printf '%P\n'); do
            if [ ! -e $src/$leaf ]; then
                mkdir -p $(dirname $src/$leaf)
                ln -sn $dst/$leaf $src/$leaf
            fi
        done
    fi
done

aggregate="$HOME/.dotfiles"
[ -e $aggregate ] && rm -r $aggregate
mv $tmp $aggregate

src=$HOME
dst=$aggregate
for leaf in $(find $dst -type l -printf '%P\n'); do
    if [ -e $src/$leaf ]; then
        echo "warning: skipping $leaf, which already exists in $src" >&2
    else
        mkdir -p $(dirname $src/$leaf)
        ln -snv $dst/$leaf $src/$leaf
    fi
done
