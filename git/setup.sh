# get the path to this script
git_cfg_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


echo "[include]" > ~/.gitconfig
echo "    path = ${git_cfg_dir}/gitconfig" >> ~/.gitconfig

#cleanup
unset -v git_cfg_dir
