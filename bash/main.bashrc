#
# bashrc for ~ANY~ Computers
#

[[ $- != *i* ]] && return

############################################################################### 
#                  SOME USEFUL FUNCTIONS TO START OFF

# SSH agent management
function start_agent {
    echo "Initializing new ssh agent"
    # spawn ssh-agent
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null 
    /usr/bin/ssh-add
}

# Compare version with A.B.C (maj.min.patch) versioning scheme 
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

# Prepend local installs and local scripts to the path
PATH=$HOME/.local/bin:$PATH
PATH=$HOME/.local/scripts:$PATH
# gem executables
if [ -d $HOME/.gem/ruby ]; then
    if [ -d $HOME/.gem/ruby/2.3.0 ]; then
        PATH=$HOME/.gem/ruby/2.3.0/bin:$PATH;
        export RUBY_GEM_VERNO=2.3.0;
    elif [ -d $HOME/.gem/ruby/2.2.0  ]; then
        PATH=$HOME/.gem/ruby/2.2.0/bin:$PATH;
        export RUBY_GEM_VERNO=2.2.0;
    fi
fi


# personal vim install 
if [ -f $HOME/.local/bin/vim ]; then
    export EDITOR="${HOME}/.local/bin/vim"
else
    export EDITOR="/usr/bin/vim"
fi



# Compiler relevant ENVARs 
export LOCAL_INC_DIR=$HOME/.local/include
export GEN_INC_DIR=/usr/local/include
export GEN_LIB_DIR=/usr/local/lib
export LOCAL_LIB_DIR=$HOME/.local/lib



export GIT_PROMPT_ONLY_IN_REPO=0
export GIT_PROMPT_SHOW_UPSTREAM=1
test_git_ver=$(versioncomp `git --version | awk '{print $3};'` 1.7.10)
if [ $test_git_ver==2 ]; then
    export GIT_PROMPT_STATUS_COMMAND=gitstatus_pre-1.7.10.sh
fi
if [ -f $HOME/.local/share/bash-git-prompt/gitprompt.sh  ]; then
    source $HOME/.local/share/bash-git-prompt/gitprompt.sh
fi
export GIT_PROMPT_THEME="Custom"

# General Alias's 
source ~/.alias

#for OS dependant things
case `uname` in
  "Darwin"*)
    export OSTYPE='osx'
    ;;
  "Linux"*)
    export OSTYPE='linux'
    ;;
esac

#for system dependant things
# Set on arc systems but not myown
if [ -z $SYSNAME ]; then
  export SYSNAME=`hostname`
fi


#If any of these exist, source them
if [ -f ~/.other.bashrc/${SYSNAME}.bashrc ]; then
    source ~/.other.bashrc/${SYSNAME}.bashrc
fi
if [ -f ~/.other.alias/${SYSNAME}.alias ]; then
    source ~/.other.alias/${SYSNAME}.alias
fi


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

#export all path addns @ the end
export PATH=$PATH
