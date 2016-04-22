function g:Mapped(fn, l)
  let new_list = deepcopy(a:l)
  call map(new_list, string(a:fn) . '(v:val)')
  return new_list
endfunction

function g:Concat(xss)
  let ys = []
  for xs in a:xss
    let ys += xs
  endfor
  return ys
endfunction

