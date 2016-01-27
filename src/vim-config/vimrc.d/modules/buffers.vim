set splitbelow                                      " new splits below
set splitright                                      " new splits to right

inoremap <c-z> <esc>:wq<cr>

nnoremap <space>j gT
nnoremap <space>k gt

nnoremap <space>q :q<cr>
nnoremap <space>w :w<cr>
nnoremap <space>e :e<space>
nnoremap <space>r :wq<cr>
nnoremap <space>t :tabedit<space>
nnoremap <space>y :q!<cr>

let g:lasttab = 1
nnoremap <tab> :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

