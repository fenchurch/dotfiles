#!/usr/bin/env sh

set -e
d="$(pwd)/$(dirname "$0")";
shopt -s dotglob
echo $d;
for file in "$d"/*
do
    case $(basename "$file") in .git | install.sh | LICENSE | README.md ) continue;; esac
    echo $file
    if [ -f "$d/$file" ]; then
        echo Linking "$d/$file" to ~
        ln -fs "$d/$file" ~/
    elif [ -d "$d/$file" ]; then
        echo Linking $file/ to ~
        ln -F "$d/$file" ~/
    fi
done
