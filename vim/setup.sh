#!/bin/bash

# get the path to this script
vim_cfg_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# link my you complete me configs into the rtp
lnif ${vim_cfg_dir}/ycm_global_config.py ${HOME}/.vim/.ycm_global_config.py

# setup dummy vimrc in home which sources the vimrc in the repo
echo "source ${vim_cfg_dir}/vimrc" > ${HOME}/.vimrc

#cleanup
unset -v vim_cfg_dir
