#brew install bash-git-prompt
set completion-ignore-case On
source .profile

GRN='\e[0;32m'
RED='\e[0;31m'
RE='\e[0m'
BLD='\e[1m'

SSH=${SSH_CLIENT:+${SSH_CLIENT%% *}}
ro(){ [ ! -w "$(pwd)" ] && printf "$RED [ro]$RE" || :; }

export PS1="\n$GRN\u$RE$SSH@\h:$BLD\e[3m\w$RE\$(ro) \n> ";
export PS2=">> "
