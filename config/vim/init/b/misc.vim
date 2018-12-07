set completeopt-=preview

set foldmethod=marker

set spelllang=en_us

" nnoremap <space>pg :GundoToggle<cr>

" autocmd FileType * set formatoptions=""             " ftplugins mess up this option often
" autocmd FileType lisp,scheme,racket,clojure,timl RainbowToggle
" nnoremap <space>pp :RainbowToggle<cr>

command Help help tab
" cabbrev help tab help
" cabbrev h tab help

au BufRead,BufNewFile *.thy setfiletype isabelle
au BufRead,BufNewFile *.thy set conceallevel=2

function! ToggleConceal()
  if &conceallevel == 0
    set conceallevel=2
  else
    set conceallevel=0
  endif
endfunction
