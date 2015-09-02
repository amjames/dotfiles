#! /bin/bash
# setup command was executed 14-May-2015 19:11:53
source ~/bin/.intelrc
echo "Env Set! running setup"

BUILD_DIR=$HOME/psi4/build/debug
if [ -e $BUILD_DIR/CMakeCache.txt ]
then
    rm $BUILD_DIR/CMakeCache.txt
fi

./setup --prefix=$HOME/installed/psi4-w-debug-flags \
    --cc=icc \
    --cxx=icpc \
    --python=`which python`\
    --type=debug \
    --cxx11=on \
    $BUILD_DIR




