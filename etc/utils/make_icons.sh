#! /usr/bin/env sh

iconsroot=/usr/share/icons/hicolor



make_all_sizes () {
    local original="$1"
    for size in `ls /usr/share/icons/hicolor | grep [0-9]x[0-9]`; do
        local converted=$original.$size
        convert $original -resize $size $converted
    done;
    return 0
}

copyall () {
    local localbase="$1"
    
    for size in `ls /usr/share/icons/hicolor | grep [0-9]x[0-9]`; do
        local tgtbase=$iconsroot/$size/apps
        cp ${localbase}.$size $tgtbase/$localbase
    done;
    return 0
}


if [ "$EUID" -ne 0 ]; then 
    echo "run using sudo"
    exit 1 
else
    echo "I am in $PWD"
    echo "I will make resized copies of app icon $1"
    echo "I will then move them all to the correct folder"
    for immage in "$@"; do
        app=${immage%.png}
        echo "Immage $immage"
        echo "app $app"
        make_all_sizes $immage
        copyall $immage
    done;
    exit 0
fi 

