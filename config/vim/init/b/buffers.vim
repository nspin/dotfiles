set hidden
set splitbelow
set splitright

fun s:nrbufs()
  let i = bufnr('$')
  let j = 0
  while i > 0
    if buflisted(i)
      let j += i
    endif
    let i -= 1
  endwhile
  return j
endfun

fun s:my_wipeout()
  let n = s:nrbufs()
  if n == 1
    quit
  else
    bwipeout
  endif
endfun

command Wipeout call <sid>my_wipeout()
command WWipeout write | Wipeout

fun s:buf_replace(new)
  let old = bufnr('%')
  exec 'edit '.a:new
  exec 'bwipeout '.old
endfun
command -nargs=? BReplace call <sid>buf_replace('<args>')

inoremap <c-z> <esc>:WWipeout<cr>
noremap <c-z> :WWipeout<cr>

nnoremap <space>j :bprev<cr>
nnoremap <space>k :bnext<cr>
nnoremap <space>d :Wipeout<cr>

nnoremap <space>n gT
nnoremap <space>m gt

nnoremap <space>q :quit<cr>
nnoremap <space>w :write<cr>
nnoremap <space>e :e 
nnoremap <space>t :tabe 
nnoremap <space>y :quit!<cr>

nnoremap <space>, gt

let s:last_tab = 1
fun! s:last_tab()
  exe 'tabn '.s:last_tab
endfun
au TabLeave * let s:last_tab = tabpagenr()

let s:last_buf = 1
fun! s:last_buf()
  exe 'buffer '.s:last_buf
endfun
au BufLeave * let s:last_buf = bufnr('%')

" TODO: use # here
" nnoremap <space>h :call <sid>last_buf()<cr>
nnoremap <tab> :call <sid>last_buf()<cr>
nnoremap <space>, :call <sid>last_tab()<cr>

fun s:buflist()
  redir => ls
  silent ls
  redir END
  let clean = []
  for buf in split(ls, '\n')
    call add(clean, split(buf, 'line')[0])
  endfor
  return clean
endfun

fun s:bufopen(line)
  exec 'buffer' matchstr(a:line, '^[ 0-9]*')
endfun

fun s:bufdelete(line)
  exec 'bwipeout' matchstr(a:line, '^[ 0-9]*')
endfun

" fun s:bufreplace(line)
"   echom a:line
"   exec 'BReplace' matchstr(a:line, '^[ 0-9]*')
" endfun

fun s:fzf_select_buf(action)
  call fzf#run( { 'source': reverse(<sid>buflist())
              \ , 'sink': function(a:action)
              \ , 'options': '+m'
              \ , 'down': len(<sid>buflist()) + 2
              \ })
endfun

fun s:fzf_select_file()
  call fzf#run( { 'sink': 'BReplace'
              \ , 'down': '40%'
              \ })
endfun

nnoremap <silent> <space>l :call <sid>fzf_select_buf('<sid>bufopen')<cr>
nnoremap <silent> <space>o :call <sid>fzf_select_file()<cr>

noremap <space>p :FZF!<cr>

fun s:fzf_dir(start)
  call fzf#run( { 'source': 'find '.a:start.' -type d | grep -v "/\."'
              \ , 'sink': 'Dirvish'
              \ })
endfun

command -nargs=1 DirOf call <sid>fzf_dir('<args>')
command DirHere call <sid>fzf_dir('.')

let i = 1
while i < 10
  exec 'noremap <space>'.i.' :buff '.i.'<cr>'
  let i += 1
endwhile
