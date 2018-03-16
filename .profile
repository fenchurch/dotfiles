PATH="/usr/local/sbin:/usr/local/bin:/usr/local/mysql/bin:~/bin:/User/rusty/bin:$PATH"
export LC_COLLATE=C 

alias s='sudo !!'
alias ll='ls -FGlAhp'                       # Preferred 'ls' implementation
alias l='ll'
alias la='ll -@'                            # Show XAttrs
alias less='less -FSRXc'                    # Preferred 'less' implementation
cd() { builtin cd "$@" && ll; }               # Always list directory contents upon 'cd'
alias cd..='cd ../'                         # Go back 1 directory level (for fast typers)
alias ..='cd ../'                           # Go back 1 directory level
alias ...='cd ../../'                       # Go back 2 directory levels
alias .3='cd ../../../'                     # Go back 3 directory levels
alias .4='cd ../../../../'                  # Go back 4 directory levels
alias .5='cd ../../../../../'               # Go back 5 directory levels
alias .6='cd ../../../../../../'            # Go back 6 directory levels
alias ~="cd ~"                              # ~:            Go Home
alias path='echo -e ${PATH//:/\\n}'         # path:         Echo all executable Paths
alias lc='launchctl'
alias slc='sudo launchctl'

linenumber() { sed ${1}\!d ${2}; }
alias line='linenumber'
mcd () { mkdir -p "$1" && cd "$1"; }        # mcd:          Makes new Dir and jumps inside
ql () { qlmanage -p "$*" >& /dev/null; }    # ql:           Opens any file in MacOS Quicklook Preview

#   lr:  Full Recursive Directory Listing
#   ------------------------------------------
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'' | less'
#   mans:   Search manpage given in agument '1' for term given in argument '2' (case insensitive)
#           displays paginated result with colored search terms and two lines surrounding each hit.             Example: mans mplayer codec
#   --------------------------------------------------------------------
mans () { man $1 | grep -iC2 --color=always $2 | less; }

#   extract:  Extract most know archives with one command
#   ---------------------------------------------------------
extract () {
if [ -f $1 ] ; then
        case $1 in
            *.tar.*)tar xjf $1;;
            *.bz2)  bunzip2 $1;;
            *.rar)  unrar e $1;;
            *.gz)   gunzip $1;;
            *.tar)  tar xf $1;;
            *.tbz2) tar xjf $1;;
            *.tgz)  tar xzf $1;;
            *.zip)  unzip $1;;
            *.Z)    uncompress $1;;
            *.7z)   7z x $1;;
            *)     echo "'$1' cannot be extracted via extract()" ;;
        esac
else
    echo "'$1' is not a valid file"
fi
}


dateToTimestamp(){ date -j -f "%a %b %e %T %Y" "$@" +%s 0>&-; }

alias myip='dig +short myip.opendns.com @resolver1.opendns.com'                    # myip:         Public facing IP Address
alias netCons='lsof -i'                             # netCons:      Show all open TCP/IP sockets
alias flushDNS='dscacheutil -flushcache'            # flushDNS:     Flush out the DNS Cache
alias lsock='sudo /usr/sbin/lsof -i -P'             # lsock:        Display open sockets
alias lsockU='sudo /usr/sbin/lsof -nP | grep UDP'   # lsockU:       Display only open UDP sockets
alias lsockT='sudo /usr/sbin/lsof -nP | grep TCP'   # lsockT:       Display only open TCP sockets
alias ipInfo0='ipconfig getpacket en0'              # ipInfo0:      Get info on connections for en0
alias ipInfo1='ipconfig getpacket en1'              # ipInfo1:      Get info on connections for en1
alias openPorts='sudo lsof -i | grep LISTEN'        # openPorts:    All listening connections
alias showBlocked='sudo ipfw list'                  # showBlocked:  All ipfw rules inc/ blocked IPs


alias dump='mysqldump -u root '
alias btmm='echo show Setup:/Network/BackToMyMac | scutil | grep $(id -u)\ : | sed "s/.*$(id -u) : \([0-9a-zA-Z\.]*\)\.$/\1/g"'
alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"
alias flushdns='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'
alias sys='syslog | tail -f'
alias plistbuddy='/usr/libexec/PlistBuddy -c "print"'
alias tm='sudo fs_usage -f filesys backupd'

btmm=`echo show Setup:/Network/BackToMyMac | scutil | grep $(id -u)\ : | sed "s/.*$(id -u) : \([0-9a-zA-Z\.]*\)\.$/\1/g"`
ping1() { ping -c 1 -W 1 ${@#*@} 1>&- && ( echo "$@ pinged"; return 0) || return 1; }

export HOMEBREW_CASK_OPTS="--appdir=/Applications"

ping0(){ for ip in ${@#*@}; do ping -c 1 -W 1 $ip 1>&- && echo "$ip" || :; done; }
ping1(){ ping -c 1 -W 1 ${@#*@} 1>&- && ( echo "$@ pinged"; return 0) || return 1; }
ip4() { ping -c 1 -t 1 "$1" | grep -Eo -m 1 '([0-9]{1,3}\.){3}[0-9]{1,3}'; }
renewdhcp(){ sudo networksetup -setbootp "${1:-Ethernet}" && sudo networksetup -setdhcp "${1:-Ethernet}"; }

readssl(){ openssl x509 -in "$@" -text; }

#   ii:  display useful host related informaton
#   -------------------------------------------------------------------
ii() {
    echo -e "\nYou are logged on ${RED}$HOST"
    echo -e "\nAdditionnal information:$NC " ; uname -a
    echo -e "\n${RED}Users logged on:$NC " ; w -h
    echo -e "\n${RED}Current date :$NC " ; date
    echo -e "\n${RED}Machine stats :$NC " ; uptime
    echo -e "\n${RED}Current network location :$NC " ;scselect
    echo -e "\n${RED}Public facing IP Address :$NC " ;myip
    #echo -e "\n${RED}DNS Configuration:$NC " ; scutil --dns
    echo
}

telegraf(){
    case "$1" in
        restart)    brew services stop telegraf && brew services start telegraf ;;
        stop)       brew services stop telegraf ;;
        start)      brew services start telegraf ;;
        
        pid)        cat /usr/local/var/run/telegraf.pid;;       
        *)          /usr/local/bin/telegraf $@ ;;
    esac
}
influxdb(){
    case "$1" in
        restart)    brew services stop influxdb && brew services start influxdb;;
        stop)       brew services stop influxdb;;
        start)      brew services start influxdb;;
        conf)       vim /usr/local/etc/influxdb.conf ;;
        pid)        cat /usr/local/var/run/influxdb.pid;;       
        *)          /usr/local/bin/influxdb $@ ;;
    esac
}
collectd(){
    case "$1" in
        restart)    brew services stop collectd && brew services start collectd ;;
        stop)       brew services stop collectd ;;
        start)      brew services start collectd ;;
        conf)       vim /usr/local/etc/collectd.conf ;;
        pid)        cat /usr/local/var/run/collectd.pid;;       
        *)          /usr/local/opt/collectd/sbin/collectd $@ ;;
    esac
}

graphite(){
    case "$1" in
        storage)    vim /opt/graphite/conf/storage-schemas.conf ;;
        resize)     find /opt/graphite/stoarge/ -type f -name '*.wsp' -exec whisper-resize.py --nobackup {} ;; 
        conf)       vim /opt/graphite/webapp/graphite/settings.py ;;
        *)          python /opt/graphite/bin/run-graphite-devel-server.py /opt/graphite ;; 
    esac
}

carbon(){
    conf=/opt/graphite/conf/carbon.conf
    case "$1" in
        restart)python /opt/graphite/bin/carbon-cache.py --config=/opt/graphite/conf/carbon.conf stop \
            &&  python /opt/graphite/bin/carbon-cache.py --config=/opt/graphite/conf/carbon.conf start
            ;; 
        conf)       vim $conf ;;
        *)   python /opt/graphite/bin/carbon-cache.py --config=$conf $1
    esac
}
google(){ 
    query="$@"
    open "https://www.google.com/search?q=$(php -r "echo urlencode('$query');")"
}

vpn () {
    local host="home.wickedidol.com"
    local ip="192.168.1.2"
    local if="Home"
    local secret='L33la is my l0v3 4eva!'
    if [[ "$(dig "$host" +short)" != $ip ]]; then
        [[ "$(scutil --nc status "$if" | head -n 1)" != "Connected" ]] && \
            scutil --nc start "$if" --secret "$secret" || :
        c=0
        while [[ "$(scutil --nc status "$if" | head -n 1)" != "Connected" && $c -lt 10 ]]; do
            [[ $c == 0 ]] && echo -n $(scutil --nc status $if | head -n 1) || echo -n "."
            sleep 1;
            ((c+=1))
        done

        echo
        echo VPN \($if\) $(scutil --nc status $if | head -n 1)
    else
        [[ "$(scutil --nc status "$if" | head -n 1)" == "Connected" ]] \
            && (scutil --nc stop "$if"; echo VPN \($if\) Disconnected) || :
    fi
}
vnc() {
    local host=$1
    local config=~/.ssh/config
    while read line; do
        if [[ "$1" == ${line%%:*} ]]; then
            host=${line#*:}
        fi
    done <<< "$(awk '
    BEGIN{ 
        RS="";
        FS="\n";
    }
    {
        if( /Hostname /) {
            host=$1
            sub(/Host /,"",host)
            hostname=$NF
            sub(/Hostname /,"",hostname)
            print host":"hostname
        }
    }' $config)"
    #check if the hosts port is open, then connect
    nc -z $host 5900 2>&-\
        && ( 
            echo "opening vnc to $1 ($host)"; 
            open vnc://"$host"; 
        ) || echo "unable to connect vnc to $1 ($host:5900)"
}

