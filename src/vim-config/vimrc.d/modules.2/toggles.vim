" --- '!' toggles ---

nnoremap <space>os :setlocal spell!<cr>
nnoremap <space>ow :setlocal wrap!<cr>
nnoremap <space>ol :setlocal list!<cr>
nnoremap <space>ob :setlocal linebreak!<cr>
nnoremap <space>or :setlocal readonly!<cr>
nnoremap <space>od :set digraph<cr>

" --- one-way toggles ---

nnoremap <space>oc :setlocal colorcolumn=80<cr>
nnoremap <space>oC :setlocal colorcolumn=0<cr>
nnoremap <space>ov :set virtualedit=all<cr>
nnoremap <space>oV :set virtualedit=block<cr>
nnoremap <space>og :noremap j gj<cr>:noremap k gk<cr>
nnoremap <space>oG :unmap j<cr>:unmap k<cr>

" --- composite toggles ---

nmap <space>ot <space>ow<space>ob<space>oc<space>og
nmap <space>oT <space>ow<space>ob<space>oC<space>oG
