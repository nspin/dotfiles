prefix=https://raw.githubusercontent.com/junegunn/fzf/master

for file in completion.bash key-bindings.bash; do
    curl $prefix/shell/$file > $file
done

# echo "function fzf-tmux () {" > fzf-tmux.bash
# curl $prefix/bin/fzf-tmux >> fzf-tmux.bash
# echo "}" >> fzf-tmux.bash
