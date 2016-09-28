command! LtxMain w | !pdflatex main.tex
command! ViewMain !zathura main.pdf &> /dev/null &
" command! LtxMain w | !pdflatex %
" command! ViewMain !zathura $(echo % | sed 's/tex$/pdf/') &> /dev/null &

inoremap <c-x> <esc>:LtxMain<cr>

nnoremap <leader>p :LtxMain<cr>
nnoremap <leader>v :ViewMain<cr>
