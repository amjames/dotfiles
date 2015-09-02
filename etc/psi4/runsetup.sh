#! /bin/bash
# setup command was executed 14-May-2015 19:11:53
source ~/bin/.intelrc

./setup --prefix=/home/amjames2/installed/psi4 \
    --cc=icc \
    --cxx=icpc \
    --python=`which python`\
    --type=release \
    --cxx11=on \
    -DENABLE_CHEMPS2=OFF \
    -DCMAKE_CXX_FLAGS=-std=C++11\
    $HOME/psi4/build/exe




