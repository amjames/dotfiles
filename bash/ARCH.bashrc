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
PATH=$HOME/.local/bin:$PATH

if [ -f $HOME/.local/bin/vim ]; then
    export EDITOR="${HOME}/.local/bin/vim"
else
    export EDITOR="/usr/bin/vim"
fi

export sysname=`uname`
SSH_ENV=$HOME/.ssh/environemnt

export GIT_PROMPT_ONLY_IN_REPO=0
export GIT_PROMPT_SHOW_UPSTREAM=1
#start the ssh agent
case $sysname in
    "Linux"*)
        if [ -f /usr/lib/bash-git-prompt/gitprompt.sh  ]; then
            source  /usr/lib/bash-git-prompt/gitprompt.sh 
        else
            if [ -f $HOME/.local/lib/bash-git-promt/gitprompt.sh  ]; then
                source $HOME/.local/lib/bash-git-prompt/gitprompt.sh
            fi
        fi
        ;;
    "Darwin"*)
        if [ -f $HOME/.local/lib/bash-git-prompt/gitprompt.sh  ]; then
            source $HOME/.local/lib/bash-git-prompt/gitprompt.sh
        fi
        ;;
esac

export GIT_PROMPT_THEME="Custom"

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


