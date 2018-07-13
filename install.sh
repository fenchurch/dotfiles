#!/bin/bash
set -e
scriptPID=$$
scriptName="$(basename "$0")"
scriptPath="$( cd "$(dirname "$0")"; pwd -P )"
pwd;
files=( .colors .vim .vimrc .bash .bashrc .bash_profile .zsh .zshrc .functions .aliases .bin .profile )
for file in "${files[@]}"; do
    echo "Linking $file to $HOME";
    ln -fs "$scriptPath/$file" "$HOME"
done
#OS dependent installers and settings
if [[ `uname` == "Darwin" ]]; then
    echo "Installing Brew and packages"
    echo "$scriptPath/install/brew"
    echo "Applying MacOS preferences"
    echo "$scriptPath/.macos"
elif [[ `uname` == "Linux" ]]; then
    #statements
    echo "Installing Linux Packages"
fi

#install SSH settings and git repos
for file in ssh git; do
    if [[ -x "$scriptPath/install/$file" ]]; then
        echo Installing $file
        $scriptPath/install/$file;
    else
        echo "Not installing $file, $scriptPath/install/$file doesnt exist"
    fi
done
#install vim vundle plugins "vim +PluginInstall +qall"
echo "Installing VIM plugins"
vim +PluginInstall +qall
