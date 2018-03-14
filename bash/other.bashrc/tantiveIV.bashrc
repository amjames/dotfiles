# vim: tw=79 sts=2 ts=2 et foldmethod=marker foldmarker={{{,}}} ft=sh:


function __handle_agents(){
  # load ssh agent info
  __source_if ${HOME}/.ssh/${SYSNAME}.agent-profile
  # Check if that agent is still running
  if [[ ! $(ps -p ${SSH_AGENT_PID} 2> /dev/null) ]];then
    # if not start it
    eval $(ssh-agent)
    # write a new file
    echo "SSH_AGENT_PID=$SSH_AGENT_PID" > ~/.ssh/${SYSNAME}.agent-profile
    echo "SSH_AUTH_SOCK=$SSH_AUTH_SOCK" >> ~/.ssh/${SYSNAME}.agent-profile
    echo "SSH_AGENT_STARTER_ID=$$" >> ~/.ssh/${SYSNAME}.agent-profile
  fi
  # Either way add our identity to the agent
  ssh-add
  __source_if ${HOME}/.gnupg/.gpg-agent-info
  if [[ ! $(ps -p `pgrep gpg-agent` 2> /dev/null) ]]; then
    eval $(gpg-agent --daemon --write-env-file ${HOME}/.gnupg/${SYSNAME}.gpg-agent-info)
  fi
  # Either way set the GPG_TTY var
  GPG_TTY=$(tty)
}



source ~/.local/.hb_token

# Need these envars to use psi4's cube_rendering script
export VMDPATH=$HOME/Softwares/VMD/vmd/vmd_MACOSXX86
export MONTAGE=/usr/local/Cellar/imagemagick/6.9.5-0/bin/montage

#NOTE: consolidate .local/scripts and .scripts/*
_add_PATH=$HOME/.scripts/utils:$_add_PATH
_add_PATH=$HOME/Softwares/molden5.4/bin:$_add_PATH
