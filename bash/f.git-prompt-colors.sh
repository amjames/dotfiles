function prompt_callback {
    qcount=0
    psicount=`ps -o comm | awk '/psi4/{n++}; END {print n+0}'`
    sshcount=`ps -o comm | awk '/ssh/{n++}; END {print n+0}'`
    case $sysname in
        "Linux")
            case $hostname in
                "brlogin1"|"brlogin2"|"nrlogin1"|"nrlogin2"*)
                    qcount=`qstatme | grep " Q " | wc -l`
                    rcount=`qstatme | grep " R " | wc -l`
                    ccount=`qstatme | grep " C " | wc -l`
                    if [ $qcount -ne 0 ] && [ $rcount -ne 0 ] && [ $ccount -ne 0 ]; then
                        echo -n "(Q:${qcount}|R:${rcount}|c:${ccount})"
                    elif [ $qcount -ne 0 ] && [ $rcount -ne 0 ]; then
                        echo -n "(Q:${qcount}|R:${rcount})"
                    elif [ $qcount -ne 0 ] && [ $ccount -ne 0 ]; then
                        echo -n "(Q:${qcount}|C:${ccount})"
                    elif [ $qcount -ne 0 ]; then
                        echo -n "(Q:${qcount})"
                    elif [ $rcount -ne 0 ] && [ $ccount -ne 0 ]; then
                        echo -n "(R:${rcount}|C:${ccount})"
                    elif [ $rcount -ne 0 ]; then 
                        echo -n "(R:${rcount})"
                    elif [ $ccount -ne 0 ]; then
                        echo -n "(C:${ccount})"
                    else
                        echo -n " "
                    fi
                    ;;
                *)
                    if [ $psicount -ne 0 ] && [ $sshcount -ne 0 ]; then
                        echo -n "(psi4:${psicount}|ssh:${sshcount})"
                    elif [ $psicount -ne 0 ]; then 
                        echo -n "(psi4:${psicount})"
                    elif [ $sshcount -ne 0 ]; then
                        echo -n "(ssh:${sshcount})"
                    else
                        echo -n " "
                    fi
                    ;;
            esac
            ;;
        "Darwin")
            if [ $psicount -ne 0 ] && [ $sshcount -ne 0 ]; then
                echo -n "(psi4:${psicount}|ssh:${sshcount})"
            elif [ $psicount -ne 0 ]; then 
                echo -n "(psi4:${psicount})"
            elif [ $sshcount -ne 0 ]; then
                echo -n "(ssh:${sshcount})"
            else
                echo -n " "
            fi
            ;;
    esac
}

override_git_prompt_colors(){
    GIT_PROMPT_THEME_NAME="Custom"
    
    
    GIT_PROMPT_COMMAND_OK="${Green}✔ ${ResetColor}[${BoldMagenta}${USER}${ResetColor}@${BoldBlue}${HOSTNAME%%.*}${ResetColor}]"
    GIT_PROMPT_COMMAND_FAIL="${Red}✘-_LAST_COMMAND_STATE_${ResetColor}[${BoldMagenta}${USER}${ResetColor}@${BoldBlue}${HOSTNAME%%.*}${ResetColor}]"
    GIT_PROMPT_START_ROOT="<${BoldRed}ROOT${ResetColor}>"

}

reload_git_prompt_colors "Custom"
