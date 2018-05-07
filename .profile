sourceFiles=(
    .aliases
    .functions
)
for src in ${sourceFiles[@]}; do 
    [ -e ~/$src ] && source ~/$src || :
done
PATH="$PATH:$HOME/.bin:$HOME/bin"
