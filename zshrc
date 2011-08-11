# shortcut to this $ZSH path is $ZSH
export ZSH=~/.zsh

. $ZSH/config
. $ZSH/window
. $ZSH/prompt
. $ZSH/aliases
. $ZSH/completion
. $ZSH/correction

# use .localrc for settings specific to one system
[[ -f ~/.localrc ]] && . ~/.localrc
