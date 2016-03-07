command! TexMain w | !pdflatex -output-directory out main.tex 
command! ViewMain !(zathura out/main.pdf &> /dev/null) &

inoremap <c-x> <esc>:TexMain<cr>

nnoremap <leader>p :TexMain<cr>
nnoremap <leader>v :ViewMain<cr>

