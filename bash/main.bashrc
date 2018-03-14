#
# bashrc for ~ANY~ Computers
#

#useful functions

function __source_if() {
  # Sources file at $1 if it exists and is regular file
  local tgt=$1
  if [ -f "${tgt}" ]; then
    source "$tgt"
  fi
}

__clean_vars="_add_PATH"
__clean_fs=""
function __finish() {
  #unset function names and var names specified above
  #add to it as you like/need, somethings don't need to live forever
  for varn in $__clean_vars;
  do
    unset $varn;
  done
  for fn in $__clean_fs;
  do
    unset -f $fn
  done
}

if [ -z $SYSNAME ]; then
  sn=`hostname`
  export SYSNAME=${sn%%.*}
fi

# Find system specific alias/bashrcs
__source_if ~/.local/bash/${SYSNAME}.bashrc
__source_if ~/.local/bash/main.alias
# git-prompt goodies
__source_if ~/.local/bash/init-prompt.sh

### Remove after transition v
__source_if ~/.alias
__source_if ~/.other.alias/${SYSNAME}.alias
__source_if ~/.other.bashrc/${SYSNAME}.bashrc
GIT_PROMPT_ONLY_IN_REPO=0
GIT_PROMPT_SHOW_UPSTREAM=1
GIT_PROMPT_THEME=Custom
__source_if ~/.local/share/bash-git-prompt/git-prompt.sh
### Remove after transition ^



# Prepend locals to path
_add_PATH=$HOME/.local/bin
_add_PATH=$HOME/.local/scripts:$_add_PATH

# If we are not in an interactive shell we are done
if [ $- == *i* ]; then
  # must be defined by something else that gets sourced along the way
  __handle_agents 
  export PATH=$_add_PATH:$PATH
  unset _add_PATH
  unset -f __handle_agents
fi
