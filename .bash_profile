GREEN='\e[0;32m'
RED='\e[0;31m'
RESET='\e[0m'
BLINK='\e[5m'
BOLD='\e[1m'
DIM='\e[2m'
ITALICON='\e[3m'
ITALICOFF='\e[23m'

ro(){ [ ! -w "$(pwd)" ] && printf "${RED} [ro]$RESET" || :; }

echo $'\n'"$(who)"

#if [ -f "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh" ]; then
#  __GIT_PROMPT_DIR=$(brew --prefix)/opt/bash-git-prompt/share
#  source "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh"
#fi
#
SSH="$( [[ -z $SSH_CLIENT ]] && echo "" || echo "( $(cut -d\  -f1 <<<$SSH_CLIENT) )" )"
export PS1="\n${GREEN}\u${RESET}${SSH}@\h:${BOLD}\e[3m\w${RESET}\$(ro) \n> ";
export PS2=">> "

[ -e ~/.profile ] && source ~/.profile || :
