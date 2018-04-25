# vim: tw=119 sts=2 ts=2 et foldmethod=marker foldmarker={{{,}}} ft=sh:

function __handle_agents(){
  # The env file needs to be hostname not sysname specific b/c multiple login nodes on each system
  local __agent_info_fn=${HOME}/.gnupg/$(hostname).gpg-agent-info
  echo "Attempting to start gpg agent"
  # This will fail if it sees that the agent is already running, no checks needed
  gpg-agent --daemon --write-env-file ${__agent_info_fn}
  source "${__agent_info_fn}"
  # Either way set the GPG_TTY var and everything should work fine
  echo "Setting GPG_TTY to $(tty)"
  export GPG_TTY=$(tty)
  export PINENTRY_USER_DATA="USE_CURSES=1"
}
module purge
module use $HOME/modulefiles
module load vim tmux
