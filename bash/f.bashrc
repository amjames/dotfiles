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
PATH=$HOME/.local/scripts:$PATH
# gem executables
if [ -f $HOME/.gem/ruby ]; then
    for version in $(ls $HOME/.gem/ruby/); do
        PATH=$HOME/.gem/ruby/$version/bin:$PATH;
    done;
fi

if [ -f $HOME/.local/bin/vim ]; then
    export EDITOR="${HOME}/.local/bin/vim"
else
    export EDITOR="/usr/bin/vim"
fi

#for OS dependant things
export sysname=`uname`
#for computer dependant things
export hostname=`hostname`

export GIT_PROMPT_ONLY_IN_REPO=0
export GIT_PROMPT_SHOW_UPSTREAM=1
test_git_ver=$(versioncomp `git --version | awk '{print $3};'` 1.7.10)
if [ $test_git_ver==2 ]; then
    export GIT_PROMPT_STATUS_COMMAND=gitstatus_pre-1.7.10.sh
fi
export EIGEN_INC_DIR=/usr/local/include/eigen3
export GEN_INC_DIR=/usr/local/include
export LOCAL_INC_DIR=$HOME/.local/include
export GEN_LIB_DIR=/usr/local/lib
export LOCAL_LIB_DIR=$HOME/.local/lib
export LD_LIBRARY_PATH=$GEN_LIB_DIR:$LOCAL_LIB_DIR
export CXX_LIB_FLAGS="-L$LOCAL_LIB_DIR -L$GEN_LIB_DIR"
export CPLUS_INCLUDE_FLAGS="-I$EIGEN_INC_DIR -I$GEN_INC_DIR -I$LOCAL_INC_DIR"
export CPLUS_INCLUDE_PATH=$EIGEN_INC_DIR:$GEN_INC_DIR:$LOCAL_INC_DIR
export LIBINT2_PATH=/usr/local/libint/2.1.0-beta2/lib/libint2.a
export LIBINT2_INC_PATH=/usr/local/libint/2.1.0-beta2/include/libint2



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
            PATH=/Library/Tex/texbin:$PATH
        fi
        source ~/.local/.hb_token
        ;;
esac

case $hostname in
    "crawDella"*)
        source ~/Git/dotfiles/bash/f.crawDella.bashrc
    ;;
    "brlogin1"|"brlogin2"*)
        source ~/Git/dotfiles/bash/f.blueridge.bashrc
    ;;
    "nrlogin1"|"nrlogin2"*)
        source ~/git/dotfiles/bash/f.newriver.bashrc
    ;;
esac


export GIT_PROMPT_THEME="Custom"

source ~/.alias
#start the ssh agent
SSH_ENV=$HOME/.ssh/environemnt
if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" >/dev/null
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ >/dev/null || {
        start_agent;
    }
else
    start_agent;
fi
