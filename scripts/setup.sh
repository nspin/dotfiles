basedir="$HOME/dotfiles"

while read line; do
    read a b <<< $(echo $line | awk '{ print $1; print $2; }')
    mkdir -p $(dirname $b)
    ln -sfnv $basedir/src/$a $b
done
