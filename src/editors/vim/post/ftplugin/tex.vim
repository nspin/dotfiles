command! LtxMain w | !pdflatex -output-directory out main.ltx
command! ViewMain !(zathura out/main.pdf &> /dev/null) &

inoremap <c-x> <esc>:LtxMain<cr>

nnoremap <leader>p :LtxMain<cr>
nnoremap <leader>v :ViewMain<cr>

