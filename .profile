sourceFiles=(
    .aliases
    .functions
    .colors
)
for src in ${sourceFiles[@]}; do 
    [ -e ~/$src ] && source ~/$src || :
done
PATH="$PATH:"~/.bin
