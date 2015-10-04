function latex#CompilePdf()
    echo "compiling ..."
    silent !clear
    silent execute "!maketex " . expand("%:t")
    echo "Done!"
    redraw!
endfunction

function latex#CleanDir()
    echo "clean up!"
    silent execute "!maketex clean"
    redraw!
endfunction


