#!/bin/bash
set -e
d="$(dirname "$0")";
cd "$d"
files=( .vim* .bash* .zsh* .functions .aliases .bin)
for file in "${files[@]}"; do
#    echo $file;
    ln -fs "$d/$file" ~/
done
#OS dependent installers and settings
if [[ `uname` == "Darwin" ]]; then
    echo "Installing Brew and packages"
    echo "$d/install/brew"
    echo "Applying preferences"
    echo "$d/.macos"
elif [[ `uname` == "Linux" ]]; then
    #statements
    echo "Installing Linux Packages"
fi

#install SSH settings and git repos
source "$d/install/ssh"
source "$d/install/git"

#install vim vundle plugins "vim +PluginInstall +qall"
vim +PluginInstall +qall
