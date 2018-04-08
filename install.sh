#!/usr/bin/env sh

set -e
d="$(dirname "$0")";
files=( .vim* .bash* .zsh* .functions .aliases )
for file in "${files[@]}"; do
    ln -s "$(dirname "$0")/$file" ~/
done
