#brew install bash-git-prompt
set completion-ignore-case On
sourceFiles=(
.aliases
.functions
.profile
)
for src in ${sourceFiles[@]}; do 
    [ -e ~/$src ] && source ~/$src || :
done

GRN='\e[0;32m'
RED='\e[0;31m'
RE='\e[0m'
BLD='\e[1m'
ro(){ [ ! -w "$(pwd)" ] && printf "$RED [ro]$RE" || :; }


SSH=${SSH_CLIENT:+${SSH_CLIENT%% *}}

\w
export PS1="\n$GRN\u$RE$SSH@\h:$BLD\e[3m\w$RE\$(ro) \n> ";
export PS2=">> "
