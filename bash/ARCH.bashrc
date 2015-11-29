#
# bashrc for ~ANY~ Computers
#

[[ $- != *i* ]] && return

function start_agent {
    echo "Initializing new ssh agent"
    # spawn ssh-agent
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null 
    /usr/bin/ssh-add
}
# .local does not have to arch speccific I can make that on mac 
# personal scripts 
PATH=$HOME/.local/bin:$PATH
# gem executables
PATH=$HOME/.gem/ruby/2.2.0/bin:$PATH

export sysname=`uname`
SSH_ENV=$HOME/.ssh/environemnt

#start the ssh agent
case $sysname in
    "Linux"*)
        if [ -f /usr/lib/bash-git-prompt/gitprompt.sh  ]; then
            source  /usr/lib/bash-git-prompt/gitprompt.sh 
        fi
        ;;
    "Darwin"*)
        if [ -f $HOME/.local/lib/bash-git-prompt/gitprompt.sh  ]; then
            source $HOME/.local/lib/bash-git-prompt/gitprompt.sh
        fi
        ;;
esac

source ~/.alias


# I dont think I will need this on mac
if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" >/dev/null
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ >/dev/null || {
        start_agent;
    }
else
    start_agent;
fi


