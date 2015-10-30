let os = subsitute(system('uname',"\n", "", ""))
function latex#CompilePdf()
    echo "compiling ..."
    silent !clear
    if os == "Linux"
        silent execute "!maketex " . expand("%:t") . " u"
    else
        silent execute "!maketex " . expand("%:t")
    endif
    echo "Done!"
    redraw!
endfunction

function latex#CleanDir()
    echo "clean up!"
    silent execute "!maketex clean"
    redraw!
endfunction


