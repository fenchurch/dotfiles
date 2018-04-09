#!/usr/bin/env sh

set -e
d="$(dirname "$0")";
#cd "$d"
files=( .vim* .bash* .zsh* .functions .aliases )
for file in "${files[@]}"; do
    echo $file;
    #ln -s "$(dirname "$0")/$file" ~/
done
#if [[ `uname` == "Darwin" ]]; then
##    source $d/
#elif [[ `uname` == "Linux" ]]; then
#    #statements
#fi
