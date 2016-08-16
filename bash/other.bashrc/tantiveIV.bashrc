# vim: tw=79 sts=2 ts=2 et foldmethod=marker foldmarker={{{,}}} ft=sh:

# Homebrew Github Token

source ~/.local/.hb_token

# add executable scripts by me 
PATH=$HOME/.scripts/utils:$PATH
PATH=$HOME/Softwares/molden5.4/bin:$PATH

export VMDPATH=$HOME/Softwares/VMD/vmd/vmd_MACOSXX86

export MONTAGE=/usr/local/Cellar/imagemagick/6.9.5-0/bin/montage

function psi4-debug() { 
  if [ -d $HOME/psi4-dev-installs/debug ];then
    export PSIDATADIR=$HOME/psi4-dev-installs/debug/share/psi4;
    $HOME/psi4-dev-installs/debug/bin/psi4 $@;
    return $?;
  else
    echo "ERROR deubg psi4 not installed on ${SYSNAME}";
    return 2;
  fi
}


