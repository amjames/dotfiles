function all#ToggleSpell()
    if &spell
        set nospell
    else 
        set spell
    endif
endfunction

let testcc=0
function all#LineLengthGuidesON()
    if exists('+colorcolumn')
        set colorcolumn=80
    else 
        w:m2=matchadd('ColorColumn', '\%>80v.\+',-1)
    endif
    let testcc=1
endfunction
function all#LineLengthGuidesOFF()
    if exists('+colorcolumn')
        set colorcolumn=0
    else
        call matchdelete(w:m2)
    endif
    let testcc=0
endfunction
function all#ToggleLineLength()
    if g:testcc
        call all#LineLengthGuidesOFF()
        let g:testcc=0
    else
        call all#LineLengthGuidesON()
        let g:testcc=1
    endif
endfunction
