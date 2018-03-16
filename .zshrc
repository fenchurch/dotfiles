# Path to your oh-my-zsh configuration.
ZSH=$HOME/.zsh

# Set name of the theme to load.
# Look in ~/.zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="rusty"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.history

# Most FreeBSD & Apple Darwin supports colors
export CLICOLOR=true
# Get color support for 'less'
export LESS="--RAW-CONTROL-CHARS"

# Use colors for less, man, etc.
[[ -f ~/.LESS_TERMCAP ]] && . ~/.LESS_TERMCAP

export GREP_OPTIONS="--color=auto"
# Interactive Comments
set -k
# dotfile glob
setopt extended_glob

#source the .profile
source ~/.profile
#end zsh options


machineInfo() {
if [[ $1 == "-v" ]]; then
    #display some computer info at login, store it in /tmp cuz it takes a second
    for i in Hardware Software Displays Memory; do 
        [ -e /tmp/$i ] && : ||\
            system_profiler SP${i}DataType 2>&- > /tmp/$i;
    done

    model=$(awk '/Model Identifier/ {print $3}' /tmp/Hardware)
    serial=$(awk '/Serial Number \(system\)/ {print $4}' /tmp/Hardware)
    os=$(awk "/System Version/" /tmp/Software | sed -e 's/.*: \(.*\)(.*/\1/g')
    cpu=$(sysctl -n machdep.cpu.brand_string)
    ram="$(( $(sysctl -n hw.memsize) / 1024**3 ))GB Ram"
    gpu=$(for i in Chipset\ Model Bus Type VRAM; do echo -n $(awk "/$i/" /tmp/Displays | sed 's/.*: //g')\ ; done;)
    net=$(services=`networksetup -listnetworkserviceorder`
        for i in $( grep Device: <<< $services | sed -e 's/.*Device\: \(.*\))/\1/g'); do
            info=$( (ifconfig $i &>/dev/null) && ifconfig $i 2>&- || : )
            name=$( grep "Device: $i" <<< $services | sed -e 's/.*Port\: \(.*\),.*/\1/g' )    
            [[ $(awk '/status: / {print $2}' <<< $info) == "active" ]] && echo $name\: $(awk '/inet / {print $2}' <<< $info) || :
        done
    )

    while read -r line; do echo $line; done <<-EOF
        $fg[yellow]${HOST//.local}$reset_color ($model $serial) $os
        $cpu, $ram
        $gpu    
        $net
EOF

else
    echo "$fg[yellow]${HOST//.local}$reset_color"
fi

while read -r line; do echo $line; done <<-EOF
Users logged on:
$(w -h)

Machine status :
$(uptime)

$(df -h | grep -v map | grep -v devfs)
EOF
#
}

networkInfo () {
    for id in `networksetup -listnetworkserviceorder | grep Device: | sed -e 's/.*Device\: \(.*\))/\1/g'`; do
        info=$( (ifconfig $id > /dev/null) && ifconfig $id || : )
        [[ $id != "" ]] && \
        [[ $( awk '/status/ {print $2}' <<< "$info" ) == 'active' ]] && \
            echo "$id-$( awk '/inet / {print $2}' <<< "$info")" || :
    done
}
# Customize to your needs...
#login info

machineInfo
