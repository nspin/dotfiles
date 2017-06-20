fun s:last_buffer_in_jumplist()
  redir => jumps
  silent jumps
  redir END
endfun
