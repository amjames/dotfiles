# vim: tw=79 sts=2 ts=2 et foldmethod=marker foldmarker={{{,}}} ft=sh:

function get_agent_profile () {
  local search_gpg_file=${HOME}/.gnupg/${SYSNAME}.gpg-agent-info
  echo "Looking at ${search_gpg_file}"
  if [ -f $search_gpg_file ]; then
    echo " Found agent profile file... Contents are"
    cat ${search_gpg_file}
    source ${search_gpg_file}
    echo "testing ...."
    if [ -z ${SSH_AUTH_SOCK+x} ]; then
      echo "ssh_auth_sock is unset"
    else
      echo "ssh_auth_sock is $SSH_AUTH_SOCK"
    fi
    if [ -z ${SSH_AGENT_PID+x} ]; then
      echo "ssh_agent_pid is unset"
    else
      echo "ssh_agent_pid is $SSH_AGENT_PID"
    fi
  else
    echo "No agent profile file found for ${SYSNAME}"
  fi
}

function check_gpg_agent () {
  local search_gpg_file=${HOME}/.gnupg/${SYSNAME}.gpg-agent-info
  local exit_val=0
  echo "GPG_AGENT_INFO = ${GPG_AGENT_INFO}"
  local __gpg_info_arr=(${GPG_AGENT_INFO//:/ })
  echo "__gpg_info_arr = $__gpg_info_arr"
  local __gpg__pid_=${__gpg_info_arr[1]}
  echo "$__gpg__pid_ is the __gpg__pid_"
  ps -p "$__gpg__pid_"
  local ret=$?
  if [[ $ret -ne '0' ]]; then
    exit_val=1
  fi
  return $exit_val
}

function check_ssh_id () {
  echo "checking ssh id"
  local num=$(ssh-add -l | wc | awk '{print $4}')
  if [[ $num -ne '4' ]]; then
    echo "--> NOT-Found"
    echo "    adding"
    # gpg-connect-agent --verbose /bye
    # ssh-add
  else
    echo "--> FOUND!"
  fi
}

function check_agent () {
  echo "checking for gpg-agent running"
  check_gpg_agent
  local chk=$?
  if [[ $chk -ne '0' ]]; then
    echo "--> NOT-found!"
    start_agent
  else
    echo "--> FOUND!"
    export GPG_TTY=$(tty)
    export GPG_AGENT_INFO
    # check_ssh_id
  fi
}

function start_agent () {
  local search_gpg_file=${HOME}/.gnupg/${SYSNAME}.gpg-agent-info
  echo "starting new ssh-agent"
  eval $(gpg-agent --daemon \
    --write-env-file ${search_gpg_file})
  export GPG_TTY=$(tty)
  echo "echo GPG_TTY Set to $GPG_TTY"
  # gpg-connect-agent --verbose /bye
  # ssh-add
}

export PATH=$HOME/conda/bin:$PATH
export PATH=$HOME/$SYSNAME/.local/bin:$PATH
