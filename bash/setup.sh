#!/bin/bash

#move the current bashrc out of the way
if [ -f ${HOME}/.bashrc ];
then
  mv ${HOME}/.bashrc ${HOME}/.bashrc.old
fi
#Get the directory of this file 
if [ -z "$bash_cfg_dir" ]; then
  _this_source="${BASH_SOURCE[0]}"
  while [ -h "$_this_source" ]; do
    _loc_dir="$( cd -P "$( dirname "$_this_source" )" && pwd )"
    _this_source="$(readlink "$_this_source")"
    [[ $_this_source != /* ]] && _this_source="$_loc_dir/$_this_source"
  done
  bash_cfg_dir="$( cd -P "$( dirname "$_this_source" )" && pwd )"
  unset -v _this_source
  unset -v _loc_dir
fi

# Only one line in the hard ~/.bashrc file sourcing the main.bashrc
echo "source ${bash_cfg_dir}/main.bashrc > ${HOME}/.bashrc"
