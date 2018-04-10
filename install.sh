#!/usr/bin/env sh
set -e
d="$(dirname "$0")";
cd "$d"
files=( .vim* .bash* .zsh* .functions .aliases )
for file in "${files[@]}"; do
#    echo $file;
    ln -fs "$d/$file" ~/
done
#OS dependent installers and settings
if [[ `uname` == "Darwin" ]]; then
    echo "Installing Brew and packages"
    source "$d/install/brew"
    echo "Applying preferences"
    source "$d/.macos"
elif [[ `uname` == "Linux" ]]; then
    #statements
    echo "Installing Linux Packages"
fi

#install SSH settings and
source "$d/install/ssh"

#install vim vundle plugins
vim +PluginInstall +qall
