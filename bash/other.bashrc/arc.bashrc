# vim: tw=79 sts=2 ts=2 et foldmethod=marker foldmarker={{{,}}} ft=sh:
#building my own softwares and loading them as modules when needed
module use $HOME/$SYSNAME/modulefiles
module restore

###default modules  ###
# installed by me
#module load git
#module load ambit
# global modules
#module load gcc/4.7.2 Anaconda Anaconda-boost cmake eigen
export GIT_PROMPT_STATUS_COMMAND='gitstatus.sh'
# psi4 run debug wrapper
function psi4-debug() { 
  if [ -d $HOME/$SYSNAME/psi4-debug ];then
    export PSIDATADIR=$HOME/$SYSNAME/psi4-debug/share/psi4;
    $HOME/$SYSNAME/psi4-debug/bin/psi4 $@;
    return $?;
  else
    echo "ERROR deubg psi4 not installed on ${SYSNAME}";
    return 2;
  fi
}

function psi4-clean() {
  if [ -d $HOME/$SYSNAME/psi4 ]; then
    export PSIDATADIR=$HOME/$SYSNAME/psi4/share/psi4;
    $HOME/$SYSNAME/psi4/bin/psi4 $@;
    return $?
  else
    echo "ERROR debug psi4 not installed on ${SYSNAME}";
    return 2;
  fi
}
# my defalut anaconda environment
source activate default
#export GIT_PROMPT_STATUS_COMMAND='gitstatus.py'

