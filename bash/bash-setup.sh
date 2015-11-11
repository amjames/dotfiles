#! /usr/bin/env sh

getos() {
    # sets the operating system envar
    tmp=`uname -a | grep -o ARCH`
    if [ "$tmp"=="ARCH" ]; then
        ARCH=true
    else
        ARCH=false
    fi

}


if [ $ARCH ]; then
    [ -f "${ARCH}.bashrc" ]
