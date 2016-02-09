command TexMain w | !pdflatex main.tex
command ViewMain !(zathura main.pdf &> /dev/null) &

inoremap <c-x> <esc>:TexMain<cr>

nnoremap <leader>p :TexMain<cr>
nnoremap <leader>v :ViewMain<cr>

