function prompt_callback {
    qcount=0
    psicount=`ps -o comm | awk '/psi4/{n++}; END {print n+0}'`
    sshcount=`ps -o comm | awk '/ssh/{n++}; END {print n+0}'`
    case $sysname in
        "Linux"*)
            hostname=`hostname -A | awk '{print $1};'`
            if [ ${hostname#*.}!="local" ]; then
                qcount=`qstatme | awk '/amjames2/{n++}; END {print n+0}'`
            fi
            ;;
        "Darwin"*)
            qcount=0
            ;;
    esac;
    if [ $qcount -ne 0 ] && [ $psicount -ne 0 ] && [ $sshcount -ne 0 ]; then

        echo -n "(q:${qcount}|psi4:${psicount}|ssh:${sshcount})"

    elif [ $qcount -ne 0 ] && [ $psicount -ne 0 ]; then

        echo -n "(q:${qcount}|psi4:${psicount})"

    elif [ $qcount -ne 0 ] && [ $sshcount -ne 0 ]; then

        echo -n "(q:${qcount}|ssh:${sshcount})"

    elif [ $qcount -ne 0 ]; then

        echo -n "(q:${qcount})"

    elif [ $psicount -ne 0 ] && [ $sshcount -ne 0 ]; then

        echo -n "(psi4:${psicount}|ssh:${sshcount})"

    elif [ $psicount -ne 0 ]; then 

        echo -n "(psi4:${psicount})"

    elif [ $sshcount -ne 0 ]; then

        echo -n "(ssh:${sshcount})"
    else
        echo -n " "
    fi
}

override_git_prompt_colors(){
    GIT_PROMPT_THEME_NAME="Custom"
    
    
    GIT_PROMPT_COMMAND_OK="${Green}✔ ${ResetColor}[${BoldMagenta}${USER}${ResetColor}@${BoldBlue}${HOSTNAME%%.*}${ResetColor}]"
    GIT_PROMPT_COMMAND_FAIL="${Red}✘-_LAST_COMMAND_STATE_${ResetColor}[${BoldMagenta}${USER}${ResetColor}@${BoldBlue}${HOSTNAME%%*}${ResetColor}]"
    GIT_PROMPT_START_ROOT="<${BoldRed}ROOT${ResetColor}>"

}

reload_git_prompt_colors "Custom"
