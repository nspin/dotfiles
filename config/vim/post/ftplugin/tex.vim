if !exists('g:tex_special')

  let g:tex_main = get(g:, 'tex_main', 'main')

  exe 'command! LtxMain w | !xelatex '.g:tex_main.'.tex'
  exe 'command! ViewMain !zathura '.g:tex_main.'.pdf &> /dev/null &'
  " command! LtxMain w | !pdflatex %
  " command! ViewMain !zathura $(echo % | sed 's/tex$/pdf/') &> /dev/null &

  inoremap <c-x> <esc>:LtxMain<cr>

  nnoremap <leader>p :LtxMain<cr>
  nnoremap <leader>v :ViewMain<cr>

endif
