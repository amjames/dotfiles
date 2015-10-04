let maplocalleader = "-"
function ToggleSpell()
    if &spell
        set nospell
    else 
        set spell
    endif
endfunction
    
nmap <localleader><space> :call latex#CompilePdf()<CR>
nmap <localleader><bs> :call latex#CleanDir()<CR>
nmap <localleader>s :call all#ToggleSpell()<CR>
