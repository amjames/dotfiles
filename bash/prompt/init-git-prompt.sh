GIT_PROMPT_ONLY_IN_REPO=0
GIT_PROMPT_SHOW_UPSTREAM=1
GIT_PROMPT_LEADING_SPACE=0
GIT_PROMPT_THEME=Custom
_this_source="${BASH_SOURCE[0]}"
while [ -h "$_this_source" ]; do
  _loc_dir="$( cd -P "$( dirname "$_this_source" )" && pwd )"
  _this_source="$(readlink "$_this_source")"
  [[ $_this_source != /* ]] && _this_source="$_loc_dir/$_this_source"
done
_prompt_cfg_dir="$(cd -P "$(dirname "$_this_source" )"  && pwd)"
unset -v _this_source
unset -v _loc_dir

GIT_PROMPT_THEME_FILE=${_prompt_cfg_dir}/git-prompt-colors.sh
__source_if ${_prompt_cfg_dir}/gitprompt.sh
