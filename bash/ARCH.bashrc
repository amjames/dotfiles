#
# bashrc for Arch Computers
#

[[ $- != *i* ]] && return

# personal scripts 
PATH=/home/ajay/.local/bin:$PATH
# gem executables
PATH=/home/ajay/.gem/ruby/2.2.0/bin:$PATH

source ~/.alias

SSH_ENV=$HOME/.ssh/environemnt

#start the ssh agent

if [ -f /usr/lib/bash-git-prompt/gitprompt.sh  ]; then
    source  /usr/lib/bash-git-prompt/gitprompt.sh 
fi

function start_agent {
    echo "Initializing new ssh agent"
    # spawn ssh-agent
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null 
    /usr/bin/ssh-add
}

if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" >/dev/null
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ >/dev/null || {
        start_agent;
    }
else
    start_agent;
fi


