" --- '!' toggles ---

" nnoremap <space>os :setlocal spell!<cr>
" nnoremap <space>ow :setlocal wrap!<cr>
" nnoremap <space>ol :setlocal list!<cr>
" nnoremap <space>ob :setlocal linebreak!<cr>
" nnoremap <space>or :setlocal readonly!<cr>
" nnoremap <space>od :set digraph<cr>

" --- one-way toggles ---

" nnoremap <space>oc :setlocal colorcolumn=80<cr>
" nnoremap <space>oC :setlocal colorcolumn=0<cr>
" nnoremap <space>ov :set virtualedit=all<cr>
" nnoremap <space>oV :set virtualedit=block<cr>
" nnoremap <space>og :noremap j gj<cr>:noremap k gk<cr>
" nnoremap <space>oG :unmap j<cr>:unmap k<cr>

" --- composite toggles ---

" nmap <space>ot <space>ow<space>ob<space>oc<space>og
" nmap <space>oT <space>ow<space>ob<space>oC<space>oG

function! PlainText()
  setlocal wrap
  setlocal linebreak
  setlocal columns=80
  setlocal nonumber
  setlocal norelativenumber
  setlocal foldcolumn=3
  hi FoldColumn ctermbg=8
  noremap j gj
  noremap k gk
endfunction

" function! GetVisualSelection()
"   return join(getline(getpos("'<")[1], getpos("'>")[1]), "\n")
" endfunction

function! WordCount() range
  let lines = join(getline(a:firstline, a:lastline), "\n")
  echo system('echo "'.lines.'" | wc -w')
endfunction

command! PlainText :call PlainText()
command! -range WC <line1>,<line2>:call WordCount()
