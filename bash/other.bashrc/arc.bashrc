# vim: tw=79 sts=2 ts=2 et foldmethod=marker foldmarker={{{,}}} ft=sh:
module purge
#building my own softwares and loading them as modules when needed
module use $HOME/$SYSNAME/modulefiles

###default modules  ###
# installed by me
module load git
#module load ambit
# global modules
module load gcc/4.7.2 Anaconda Anaconda-boost cmake eigen




export AMBIT_INCLUDE=$HOME/$SYSNAME/ambit/include
export AMBIT_LIB=$HOME/$SYSNAME/ambit/lib
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
#export GIT_PROMPT_STATUS_COMMAND='gitstatus.py'

