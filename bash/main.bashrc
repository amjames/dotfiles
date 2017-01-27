#
# bashrc for ~ANY~ Computers
#

[[ $- != *i* ]] && return

###############################################################################
#                  SOME USEFUL FUNCTIONS TO START OFF
# SSH agent management
function start_agent () {
  $HOME/.local/share/utils/agent_running.py
  if [ $? -ne 0 ];then
    echo "Initializing new ssh agent"
    eval $(ssh-agent)
    ssh-add
    echo "export SSH_AGENT_PID=$SSH_AGENT_PID" > ~/.ssh/agent-profile
    echo "export SSH_AUTH_SOCK=$SSH_AUTH_SOCK" >> ~/.ssh/agent-profile
  else
    echo " Found running ssh agent, exporting to env"
    if [ -f ~/.ssh/agent-profile ]; then
      source ~/.ssh/agent-profile
    else
      echo "did not work"
      # echo "export SSH_AGENT_PID=$SSH_AGENT_PID" > ~/.ssh/agent-profile
      # echo "export SSH_AUTH_SOCK=$SSH_AUTH_SOCK" >> ~/.ssh/agent-profile
    fi
  fi
  trap 'rm ~/.ssh/agent-profile && ssh-agent -k; exit' 0
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
  if [ -f $HOME/$SYSNAME/.local/bin/vim ]; then
    export EDITOR="${HOME}/${SYSNAME}/.local/bin/vim"
  else
    export EDITOR="/usr/bin/vim"
  fi
fi



# Compiler relevant ENVARs



export GIT_PROMPT_ONLY_IN_REPO=0
export GIT_PROMPT_SHOW_UPSTREAM=1
export GIT_PROMPT_THEME="Custom"

# General Alias's

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
  sn=`hostname`
  SYSNAME=${sn%%.*}
  export $SYSNAME
fi

#If any of these exist, source them
if [ -f ~/.other.bashrc/${SYSNAME}.bashrc ]; then
  source ~/.other.bashrc/${SYSNAME}.bashrc
fi
source ~/.alias
if [ -f ~/.other.alias/${SYSNAME}.alias ]; then
  source ~/.other.alias/${SYSNAME}.alias
fi


#start the ssh agent if not a tmux window/shell
if [ -z $TMUX ]; then
  echo " not in a tmux sub-shell trying to start ssh-agent"
  start_agent
else
  echo " In a tmux sub-shell assuming the parent has done ssh-agenting "
fi

if [ -f $HOME/.local/share/bash-git-prompt/gitprompt.sh  ]; then
  source $HOME/.local/share/bash-git-prompt/gitprompt.sh
fi
#export all path addns @ the end
export PATH=$PATH
