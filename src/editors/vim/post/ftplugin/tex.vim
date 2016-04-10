command! LtxMain w | !(cd ..; ./build)
command! ViewMain !(zathura ../main.pdf &> /dev/null) &

inoremap <c-x> <esc>:LtxMain<cr>

nnoremap <leader>p :LtxMain<cr>
nnoremap <leader>v :ViewMain<cr>

