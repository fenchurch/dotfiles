sourcefiles="
.aliases
.functions
.profile
"

GREEN='\e[0;32m'
RED='\e[0;31m'
RESET='\e[0m'
BOLD='\e[1m'

ro(){ [ ! -w "$(pwd)" ] && printf "$RED [ro]$RESET" || :; }

echo $'\n'"$(who)"

SSH=${SSH_CLIENT:+${SSH_CLIENT%% *}}
export PS1="\n$GREEN\u$RESET$SSH@\h:$BOLD\e[3m\w$RESET\$(ro) \n> ";
export PS2=">> "

for i in $sourcefiles; do
    [ -e ~/$i ] && source ~/$i || :
done
