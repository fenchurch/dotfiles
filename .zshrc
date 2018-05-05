# Path to your oh-my-zsh configuration.
ZSH=$HOME/.zsh

# Set name of the theme to load.
# Look in ~/.zsh/themes/
ZSH_THEME="Powerlevel9k/powerlevel9k"

DEFAULT_USER=rusty
POWERLEVEL9K_MODE='nerd-patched'
#OS
POWERLEVEL9K_OS_ICON_FOREGROUND='000'
POWERLEVEL9K_OS_ICON_BACKGROUND='010'
#DIR
POWERLEVEL9K_DIR_HOME_FOREGROUND='000'
POWERLEVEL9K_DIR_HOME_BACKGROUND='012'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND='000'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND='012'
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND='000'
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND='012'

POWERLEVEL9K_HISTORY_FOREGROUND='011'
POWERLEVEL9K_HISTORY_BACKGROUND='000'

POWERLEVEL9K_CUSTOM_NOW_PLAYING='~/.bin/nowplaying'
POWERLEVEL9K_CUSTOM_NOW_PLAYING_FOREGROUND='012'
POWERLEVEL9K_CUSTOM_NOW_PLAYING_BACKGROUND='000'

POWERLEVEL9K_CUSTOM_CONTEXT='~/.bin/context'

#Context
#
#POWERLEVEL9K_ALWAYS_SHOW_CONTEXT=true
POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND='014'
POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND='000'
POWERLEVEL9K_SSH_FOREGROUND='014'
POWERLEVEL9K_SSH_BACKGROUND='000'

#POWERLEVEL9K_DIR_SHOW_WRITABLE=true
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir_writable dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status background_jobs  history custom_now_playing custom_context)
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_RPROMPT_ON_NEWLINE=
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%F{010}\u276f%f%k "
#Comment this out to disable weekly auto-update checks
DISABLE_AUTO_UPDATE="true"
# disable colors in ls
# DISABLE_LS_COLORS="true"
# disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"
# red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"
# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

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

#source .profile 
source ~/.profile
