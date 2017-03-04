# vim: tw=79 sts=2 ts=2 et foldmethod=marker foldmarker={{{,}}} ft=sh:

# Homebrew Github Token

function get_agent_profile () {
  if [ -f $HOME/.ssh/$SYSNAME.agent-profile ]; then
    echo " Found agent profile file... contents are"
    cat $HOME/.ssh/$SYSNAME.agent-profile
    source $HOME/.ssh/$SYSNAME.agent-profile
  else
    echo "No agent profile file found for ${SYSNAME}"
  fi
}

function check_agent () {
  echo "checking SSH_AGENT_PID is running?"
  ps -p $SSH_AGENT_PID
  local ret=$?
  if [[ $ret -ne '0' ]]; then
    echo "no, removing stale profile"
    rm $HOME/.ssh/$SYSNAME.agent-profile
    start_agent
  else
    echo " it is still working adding identity"
    ssh-add
    return 0
  fi
}

function start_agent () {
  echo "starting new ssh-agent"
  eval $(ssh-agent)
  ssh-add
  echo "export SSH_AGENT_PID=$SSH_AGENT_PID" > ~/.ssh/${SYSNAME}.agent-profile
  echo "export SSH_AUTH_SOCK=$SSH_AUTH_SOCK" >> ~/.ssh/${SYSNAME}.agent-profile
  echo "export SSH_AGENT_STARTER_ID=$$" >> ~/.ssh/${SYSNAME}.agent-profile
}

source ~/.local/.hb_token

# add executable scripts by me 
PATH=$HOME/.scripts/utils:$PATH
PATH=$HOME/Softwares/molden5.4/bin:$PATH
# VMD software pre complied 32 bit binary
export VMDPATH=$HOME/Softwares/VMD/vmd/vmd_MACOSXX86
# Image magic's Montage for joining density/MO plots w/ labels
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
export LOCAL_INC_DIR=$HOME/.local/include
export GEN_INC_DIR=/usr/local/include
export EIGEN_INCLUDE=/usr/local/include/eigen3
export GEN_LIB_DIR=/usr/local/lib
export LOCAL_LIB_DIR=$HOME/.local/lib


