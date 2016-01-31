source $stdenv/setup
cp --no-preserve=mode $src fzf.vim

cp --no-preserve=mode $aPatch fzf.vim.patch
echo "> let s:fzf_go = '$fzf/bin/fzf'" >> fzf.vim.patch
cat $bPatch >> fzf.vim.patch
echo "> let s:fzf_tmux = '$fzfTmux/bin/fzf-tmux'" >> fzf.vim.patch

patch fzf.vim fzf.vim.patch

mkdir -p $out/plugin
mv fzf.vim $out/plugin
