# get the path to this script
git_cfg_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "setting include.path to ${git_cfg_dir}"
echo "setting init.templatedir to ${git_cfg_dir}/git_template"
echo "setting core.excludesfile to ${git_cfg_dir}/gitignore_global"
git config --global include.path "${git_cfg_dir}/gitconfig"
git config --global init.templatedir "${git_cfg_dir}/git_template"
git config --global core.excludesfile "${git_cfg_dir}/gitignore_global"


#cleanup
unset -v git_cfg_dir
