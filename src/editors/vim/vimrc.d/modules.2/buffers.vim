set splitbelow
set splitright

inoremap <c-z> <esc>:wq<cr>

nnoremap <space>j gT
nnoremap <space>k gt

nnoremap <space>q :quit<cr>
nnoremap <space>w :write<cr>
nnoremap <space>e :edit<cr>
nnoremap <space>r :wq<cr>
nnoremap <space>t :tabedit<cr>
nnoremap <space>y :quit!<cr>

let s:last_tab = 1
au TabLeave * let s:last_tab = tabpagenr()

function! s:LastTab()
  exec 'tabn '.s:last_tab
endfunction

nnoremap <tab> :call <SID>LastTab()<CR>
