# vim: tw=79 sts=2 ts=2 et foldmethod=marker foldmarker={{{,}}} ft=sh:

# Homebrew Github Token

source ~/.local/.hb_token

# add executable scripts by me 
PATH=$HOME/.scripts/utils:$PATH
PATH=$HOME/Softwares/molden5.4/bin:$PATH
# VMD software pre complied 32 bit binary
export VMDPATH=$HOME/Softwares/VMD/vmd/vmd_MACOSXX86
# Image magic's Montage for joining density/MO plots w/ labels
export MONTAGE=/usr/local/Cellar/imagemagick/6.9.5-0/bin/montage

# local include to osx personal systems
export LOCAL_INC_DIR=$HOME/.local/include
export GEN_INC_DIR=/usr/local/include
export GEN_LIB_DIR=/usr/local/lib
export LOCAL_LIB_DIR=$HOME/.local/lib


