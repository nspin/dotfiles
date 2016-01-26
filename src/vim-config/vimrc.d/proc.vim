let g:slime_target = "tmux"

nmap <c-c><c-f> vaF<c-c><c-c>``
nmap <space>v v%<c-c><c-c>

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_mode_map = {
    \ "mode": "passive",
    \ "active_filetypes": [],
    \ "passive": [] }

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_wq = 0

nnoremap <space>ps :SyntasticCheck
nnoremap <space>pe :Errors

nnoremap <space>p1 :SlimeSend1 "!-1"<cr>
