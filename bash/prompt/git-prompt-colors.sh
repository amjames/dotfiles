function prompt_callback {
  echo -n ""
}

override_git_prompt_colors(){
    GIT_PROMPT_THEME_NAME="Custom"
    GIT_PROMPT_COMMAND_OK="${Green}✔ ${ResetColor}[${BoldMagenta}${USER}${ResetColor}@${BoldBlue}${HOSTNAME%%.*}${ResetColor}]"
    GIT_PROMPT_COMMAND_FAIL="${Red}✘-_LAST_COMMAND_STATE_${ResetColor}[${BoldMagenta}${USER}${ResetColor}@${BoldBlue}${HOSTNAME%%.*}${ResetColor}]"
    GIT_PROMPT_START_ROOT="<${BoldRed}ROOT${ResetColor}>"
    GIT_PROMPT_VIRTUALENV="(${Blue}_VIRTUALENV_${ResetColor})"
}

reload_git_prompt_colors "Custom"
