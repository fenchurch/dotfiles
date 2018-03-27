# Path to your oh-my-zsh configuration.
ZSH=$HOME/.zsh

# Set name of the theme to load.
# Look in ~/.zsh/themes/
ZSH_THEME="rusty"

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

#source aliases and functions
source ~/.aliases
source ~/.functions
