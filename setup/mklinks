#!/bin/sh

set -e

# becuase readlink -m is nonstandard.
# dotfiles="$(python -c "from os.path import dirname, abspath; print dirname(dirname(abspath('$0')))")"
dotfiles="$(dirname "$(cd "$(dirname "$0")" && pwd)")"

(while read line; do
    echo "$line"
    IFS=' ' read link target <<< "$line"
    mkdir -p $HOME/$(dirname $target)
    ln -sfnv $dotfiles/config/$link $HOME/$target
done) < $(dirname $0)/$1
