#remove vprevious rprompt
setopt transient_rprompt
# Color shortcuts
R="%{${fg[red]}%}"
C="%{${fg[cyan]}%}"
G="%{${fg[green]}%}"
M="%{${fg[magenta]}%}"
W="%{${fg[white]}%}"
Y="%{${fg[yellow]}%}"
B="%{${fg[blue]}%}"
K="%{${fg[black]}%}"
Gr="\033[7;49;95m"
RE="%{$reset_color%}"

#timefmt
TIMEFMT=""

#git
ZSH_THEME_GIT_PROMPT_PREFIX="[git:"
ZSH_THEME_GIT_PROMPT_SUFFIX="]$RE"
ZSH_THEME_GIT_PROMPT_DIRTY="$R▼ "
ZSH_THEME_GIT_PROMPT_CLEAN="$G▲ $K"

ARROW=">"
ROOT_ARROW="$"
SSH=

function time_prompt_info {
    local t="${(%):-%*}"
    [[ $TIMEFMT = "12hour" ]] && t="${$((${t%%:*} % 12))/0/12}:${t#*:}"
    echo -en $t 
}

function user_prompt_info {
    #if you're on a different user than yours
    local user="${(%):-%n}$RE"
    #if you're on the root, make it yellow
    [ -z $UID ] && c="$Y" || user="$W" 
    echo -n "$c$user"
}
function ssh_prompt_info {
    
    local ssh=${SSH_CLIENT%% *}
    local locale=".local"

}
function git_prompt_info {
   ref=$(git symbolic-ref HEAD 2> /dev/null) || return
   echo "$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_PREFIX$(current_branch)$ZSH_THEME_GIT_PROMPT_SUFFIX "
}
function perms_prompt_info {

    dir="${(%)1:-%d}"
    perms=$(IFS=\ ;echo ${$(stat "$dir")[3]})
    #if user is owner, show permissions
    [[ -O $dir ]] && perm="u(${perms:1:3})" || \
    #if user is in the group, show permissions
    for g in $( id -G $EUID ); do
        [[ $(IFS=\ ;echo ${$(stat -r "$dir")[6]}) == $g ]] && perm="g(${perms:4:3})"
    done
    #if perm is empty, give the "others" permissions
    echo ${perm:-"o(${perms:7:3})"}
    IFS=$oIFS
}

function length {
    #clear the formatting
    local cl='%([BSUbfksu]|([FB]|){*})'
    #find string length unformatted
    local input=$( echo $1 | sed -e "s,$(echo -e "\e")\[[0-9;]*[a-zA-Z],,g" )
    echo "${#${(S%%)input//$~cl/}}"
}

function column {
    echo "${(l:$(( $(tput cols) - $(length $1) ))::-:)}"
}
function shorten {
    #arg 2 or nothing
    local offset=$(length ${2:-})
    #arg 3 or term width    
    local max=${3:-$(tput cols)}
    #arg 4 what to shorten with
    local fill=${4:-".."}
    #filter it %max<placeholder<original%<<
    local filtered="%$(( $max - $offset - ${#fill} ))<"$fill"<"$1"%<<"
    #local start=${#:-${1%%"$filtered"}}
    #echo ${1%$start}
    echo -n "$filtered"
}
function build_prompt() {
    local host="${(%):-%m}"
    local time="$(time_prompt_info)"
    local user="$(user_prompt_info)"
    local git="$(git_prompt_info)"
    local err="$R%(?..-> %? <-\n)$RE"
    local dir="${(%):-%~}"
    local perms="$Gr$(perms_prompt_info)$RE"
    local pr_left=" $git$perms "
    local pr_right=" $time "
    pr_left="$(shorten "$dir" "$pr_left$pr_right" )$pr_left"
    local pr_center="$(column "${pr_left}${pr_right}" )"
    
    arrow="$W\n$ARROW"
    [[ $UID -eq 0 ]] && arrow="$Y\n$ROOT_ARROW"; 
    
    echo -e "$err"
    echo -en "$C$pr_left"
    echo -en "$K$pr_center"
    echo -en "$pr_right"
    echo -en "$arrow "
}
function build_rprompt() {
    [[ -z $UID ]] && \
        out=$Y"root" || out="$RE${(%):-%n}"
    [[ $SSH_CLIENT == "" ]] || \
        out="${out:-%n}$RE@$M${HOST//.local}$RE$(ssh_prompt_info)"
    out+=" $RE"
    echo -en "$out"
}
#reset the color before exe
function preexec {
    print -Pr "$bg[black]$G!%h"$RE - $(time_prompt_info)
}

PS1='$( build_prompt )'
PS2='%_${ARROW} '
RPROMPT='$( build_rprompt )'
