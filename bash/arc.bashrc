# vim: tw=79 sts=2 ts=2 et foldmethod=marker foldmarker={{{,}}} ft=sh:

function __handle_agents(){
  __source_if ${HOME}/.gnupg/${SYSNAME}.gpg-agent-info
  local __gpg_info_arr=(${GPG_AGENT_INFO//:/ })
  local __gpg__pid_=${__gpg_info_arr[1]}
  ps -p ${__gpg_pid} 2>&1 >/dev/null
  local _agent_running="$?"
  if [[ ! $_agent_running == "0"]]; then
    eval $(gpg-agent --daemon --write-env-file ${HOME}/.gnupg/${SYSNAME}.gpg-agent-info)
  fi
  # Either way set the GPG_TTY var
  GPG_TTY=$(tty)
}
