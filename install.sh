#!/usr/bin/env sh

set -e
d="$(dirname "$0")";

for file in .vim* .bash* .zsh* .profile; do
    ln -s "$(dirname "$0")/$file" ~/
done

