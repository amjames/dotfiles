#
# bashrc for ~ANY~ Computers
#

[[ $- != *i* ]] && return

###############################################################################
#                  SOME USEFUL FUNCTIONS TO START OFF
# SSH agent management
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
_add_PATH=$HOME/.local/bin
_add_PATH=$HOME/.local/scripts:$_add_PATH
# gem executables
if [ -d $HOME/.gem/ruby ]; then
  if [ -d $HOME/.gem/ruby/2.3.0 ]; then
    _add_PATH=$HOME/.gem/ruby/2.3.0/bin:$_add_PATH
    RUBY_GEM_VERNO=2.3.0;
  elif [ -d $HOME/.gem/ruby/2.2.0  ]; then
    _add_PATH=$HOME/.gem/ruby/2.2.0/bin:$_add_PATH
    RUBY_GEM_VERNO=2.2.0;
  fi
fi


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
  export SYSNAME=${sn%%.*}
fi

#If any of these exist, source them
if [ -f ~/.other.bashrc/${SYSNAME}.bashrc ]; then
  source ~/.other.bashrc/${SYSNAME}.bashrc
fi
source ~/.alias
if [ -f ~/.other.alias/${SYSNAME}.alias ]; then
  source ~/.other.alias/${SYSNAME}.alias
fi
export EDITOR="$(which vim)"
if [ -f $HOME/.local/share/bash-git-prompt/gitprompt.sh  ]; then
  source $HOME/.local/share/bash-git-prompt/gitprompt.sh
fi


#if we are not in a tmux subshell then start the ssh agent (if needed) and export the path
if [ -z $TMUX ]; then
  get_agent_profile
  check_agent
  export PATH=$_add_PATH:$PATH
else
  echo " In a tmux sub-shell assuming the parent has done ssh-agenting "
fi
