" OVERLY COMPLICATED CONDITIONAL AESTHETICS

if has('win32')
    colorscheme nicebox
elseif has('unix')
    if &term == "xterm"
        colorscheme solarized
    " detect if on mac
    let s:uname = system("uname -s")
    if s:uname == "Darwin"
        let g:solarized_termcolors = 256
        colorscheme solarized
    elseif &term == "xterm-256color" || &term == "screen-256color"
        let g:solarized_termcolors = 256
        colorscheme solarized
    elseif &term == "linux"
        set t_ve+=[?81;0;112c
        let g:jellybeans_use_lowcolor_black = 0
        colorscheme jellybeans
    endif
endif
