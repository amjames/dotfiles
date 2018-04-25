function replace_git_dir_in_pwd() {
  local git_root=$(git rev-parse --show-toplevel)
  local here=$(pwd)
  local git_root_repl="git:$(basename ${git_root})"
  echo -n "${here//$git_root/$git_root_repl}"
}

function begin_dots_end() {
  local_full
}

function prompt_callback {
  local path_part="\w"
  local p_color="${Yellow}"
  local p_lead=""
  local p_tail=""
  if [[ $(we_are_on_repo) == 1 ]]; then
    p_color="${Red}"
    p_lead="<"
    path_part=$(replace_git_dir_in_pwd)
    p_tail=">\n"
  fi
  local prompt_len=$(printf $(gp_add_virtualenv_to_prompt) | sed 's/\\\[//g' | sed 's/\\\]//g' | perl -pe 's/\e([^\[\]]|\[.*?[a-zA-Z]|\].*?\a)//g' | wc -c)
  local path_len=$(printf ${path_part} | sed 's/\\\[//g' | sed 's/\\\]//g' | perl -pe 's/\e([^\[\]]|\[.*?[a-zA-Z]|\].*?\a)//g' | wc -c)
  prompt_len=$(expr $prompt_len + $path_len)
  prompt_len=$(expr $prompt_len + $(printf ${GIT_PROMPT_USR_HOST} | sed 's/\\\[//g' | sed 's/\\\]//g' | perl -pe 's/\e([^\[\]]|\[.*?[a-zA-Z]|\].*?\a)//g' | wc -c))
  local room_left=$(expr $(tput cols) - $prompt_len)
  if [ $room_left -lt 0 ];
  then
    p_lead="\n${p_lead}"
  fi
  if [ $path_len -gt $(tput cols) ];
  then
    if [[ $(we_are_on_repo) == 1 ]]; then
      path_part=$(echo ${path_part/#git/g} | sed "s:\([^/\.]\)[^/]*/:\1/:g")
    else
      path_part=$(printf ${path_part} | sed "s:\([^/\.]\)[^/]*/:\1/:g")
    fi
  fi
  echo -n "$p_color$p_lead$path_part$p_tail${ResetColor}"
}

override_git_prompt_colors(){
  # Formula is $virtual_env $START $gitstuff $END
    GIT_PROMPT_THEME_NAME="Custom"
    case $SYSNAME in
      blueridge)
        _hn_color=$BoldBlue
        ;;
      newriver)
        _hn_color=$BoldGreen
        ;;
      cascades)
        _hn_color=$BoldBlue
        ;;
      dragonstooth)
        _hn_color=$BoldRed
        ;;
      *)
        _hn_color=$BoldCyan
        ;;
    esac
    GIT_PROMPT_USR_HOST="[${BoldMagenta}${USER}${ResetColor}@${_hn_color}${HOSTNAME%%.*}${ResetColor}]"
    GIT_PROMPT_COMMAND_OK="${Green}✔ ${ResetColor}"
    GIT_PROMPT_COMMAND_FAIL="${Red}>✘<${ResetColor}"
    GIT_PROMPT_START_USER="_LAST_COMMAND_INDICATOR_${GIT_PROMPT_USR_HOST}"
    GIT_PROMPT_START_ROOT=$GIT_PROMPT_START_USER"<${BoldRed}ROOT${ResetColor}>"
    GIT_PROMPT_VIRTUALENV="(${Blue}_VIRTUALENV_${ResetColor})"
}

reload_git_prompt_colors "Custom"
