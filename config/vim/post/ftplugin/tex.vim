command! LtxMain w | !pdflatex %
command! ViewMain !zathura $(echo % | sed 's/tex$/pdf/') &> /dev/null &

inoremap <c-x> <esc>:LtxMain<cr>

nnoremap <leader>p :LtxMain<cr>
nnoremap <leader>v :ViewMain<cr>

