prefix=https://raw.githubusercontent.com/junegunn/fzf/master/shell

for file in completion.bash key-bindings.bash; do
    curl $prefix/$file > $file
done
