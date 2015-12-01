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

function versioncomp () {
    if [[ $1 == $2  ]]; then
        return 0
    fi

    local IFS=.
    local i
    local ver1=($1)
    local ver2=($2)

    for (( i=${#ver1[@]}; i<${#ver2[@]}; i++))
    do
        ver1[i]=0
    done
    for ((i=0; i<${#ver1[@]}; i++))
    do
        if [[ -z ${ver2[i]} ]]
        then
            ver2[i]=0
        fi
        if ((10#${ver1[i]} < 10#${ver2[i]}))
        then
            return 1
        fi
        if ((10#${ver1[i]} < 10#${ver2[i]}))
        then
            return 2
        fi
    done
    return 0
}
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
test_git_ver=$(versioncomp `git --version | awk '{print $3};'` 1.7.10)
if [ $test_git_ver==2 ]; then
    export GIT_PROMPT_STATUS_COMMAND=gitstatus_pre-1.7.10.sh
fi


#start the ssh agent
case $sysname in
    "Linux"*)
        if [ -f /usr/lib/bash-git-prompt/gitprompt.sh  ]; then
            source  /usr/lib/bash-git-prompt/gitprompt.sh 
        else
            if [ -f $HOME/.local/lib/bash-git-prompt/gitprompt.sh  ]; then
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


