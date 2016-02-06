command TexMain w | !pdftex main.tex
command ViewMain !zathura main.pdf &

inoremap <c-x> <esc>:TexMain<cr>

nnoremap <leader>p :TexMain<cr>
nnoremap <leader>v :ViewMain<cr>

