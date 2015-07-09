### .cshrc 
#Andrew M. James 
#written for Herbert (macbook) 
echo ".cshrc!"
set filec
set correct=cmd
set autolist=ambiguous

######Define Path#######################################
#Personal scripts (source in scripts, executable in bin)
set path = (/usr/local/bin $path)
#messin with psi4 might have to edit this
#personal stuff usally homemade
set path = (~/bin $path)
set path = (/usr/local/Library $path)
# my script repo
set path = (~/scripts/exe $path)
set path = (/usr/local/include $path)
set path = (/usr/local/bin $path)
set path = (/usr/local/texlive/2014/bin/x86_64-darwin $path)
#look for mac os stuff last, homebrew first 
set path = ($path /usr/bin )
set path = ($path /Users/ajay/builds/psi4/bin) 


##Set Prompt
set prompt="%B%{\033[34m%}[%P-%d][>%b"
##Set editor for git commit messages 
setenv EDITOR /Applications/MacVim.app/Contents/MacOS/Vim
setenv VISUAL /Applications/MacVim.app/Contents/MacOS/Vim




####Define Aliases####################################
#Temporary sorting out compilers 

#General
alias vim  '/Applications/MacVim.app/Contents/MacOS/Vim'
alias c 'clear'
alias ls 'ls -G -F'
alias als 'ls -aGF'
alias alls 'ls -aGFl'
alias lls 'ls -GFl'
alias hls 'll -hGF'
alias dls 'ls -dGF */'
alias vi 'vim'

#g09 shortcuts 
alias gvio 'vi output.log'
alias gvii 'vi input.com'
#psi shortcuts 
alias vio 'vi output.dat'
alias vii 'vi input.dat'
alias vib 'vi basis.dat'
alias tfo 'tail -f output.dat'

#alias btthelp 'open ~/Documents/BTTHELP.pdf'
alias btthelp 'less ~/bin/btthelp'
#plotting for OR project 
alias csv2plot 'python ~/src/pyscript/plot_rots.py'  

# Other computers
alias cer 'ssh ajay@cerebro.chem.vt.edu'
alias blue 'ssh amjames2@blueridge1.arc.vt.edu'
alias s2i2 'ssh crawdad@login.wmd-lab.org'
alias sirius 'ssh ajay@sirius.chem.vt.edu'




