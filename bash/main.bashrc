#
# bashrc for ~ANY~ Computers
#
__DBG="yes"
# Functions #
function __source_if() {
  # Sources file at $1 if it exists and is regular file
  local tgt=$1
  if [ -f "${tgt}" ]; then
    echo "Found file ${tgt}, sourcing it"
    source "$tgt"
  fi
}
__clean_vars="_add_PATH __mybash_cfg_dir"
__clean_fs="__handle_agents"
function __finish() {
  # unset function names and var names specified above
  # add to it as you like/need, somethings don't need to live forever 
  # and it can be a good idea to clear out un-needed functions when you 
  # are done with them
  for varn in $__clean_vars;
  do
    unset -v $varn;
  done
  unset -v __clean_vars
  for fn in $__clean_fs;
  do
    unset -f $fn
  done
  unset -v __clean_fs
  #This function will self destruct in 4, 3, 2, 1
  unset -f __finish
}

function __handle_agents() {
  # Override this in ${SYSNAME}.bashrc with an appropriate definition
  echo "No agent config for ${SYSNAME}"
}

# Get the dir that this file is in 
# (the actual file if it is a link)
if [ -z "$__mybash_cfg_dir" ]; then
  _this_source="${BASH_SOURCE[0]}"
  while [ -h "$_this_source" ]; do
    _loc_dir="$( cd -P "$( dirname "$_this_source" )" && pwd )"
    _this_source="$(readlink "$_this_source")"
    [[ $_this_source != /* ]] && source="$_loc_dir/$_this_source"
  done
  __mybash_cfg_dir="$( cd -P "$( dirname "$_this_source" )" && pwd )"
  unset -v _this_source
  unset -v _loc_dir
fi


# Two reasons:
# 1. Some arc systems are not properly configured so the important $SYSNAME var is never set
# 2. I use sysname on all systems even those without a shared filesystem just for consistently
if [ -z $SYSNAME ]; then
  sn=`hostname`
  export SYSNAME=${sn%%.*}
  unset -v sn
fi

# # Find system specific alias/bashrcs
# __source_if ${__mybash_cfg_dir}/${SYSNAME}.bashrc
# __source_if ${__mybash_cfg_dir}/main.alias
# __source_if ${__mybash_cfg_dir}/${SYSNAME}.alias

# # git-prompt goodies
# __source_if ${__mybash_cfg_dir}/prompt

### Remove after transition v
__source_if ~/.other.bashrc/${SYSNAME}.bashrc
__source_if ~/.alias
__source_if ~/.other.alias/${SYSNAME}.alias
GIT_PROMPT_ONLY_IN_REPO=0
GIT_PROMPT_SHOW_UPSTREAM=1
GIT_PROMPT_THEME=Custom
__source_if ~/.local/share/bash-git-prompt/gitprompt.sh
### Remove after transition ^


### Set up conda + activate default env
__source_if ${HOME}/conda/etc/profile.d/conda.sh
conda activate

# Prepend locals to path
_add_PATH=$HOME/.local/bin
_add_PATH=$HOME/.local/scripts:$_add_PATH

# If we are in an interactive session
# we set up our agents.
if [[ $- == *i* ]]; then
  __handle_agents
fi
# If we are not in a tmux sub-shell we export the modified path
if [[ -z "$TMUX" ]]; then
  export PATH=$_add_PATH:$PATH
fi

__finish
