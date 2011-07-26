# shortcut to this $ZSH path is $ZSH
export ZSH=~/.dotfiles

. $ZSH/zsh/config
. $ZSH/zsh/window
. $ZSH/zsh/prompt
. $ZSH/zsh/aliases
. $ZSH/zsh/completion
. $ZSH/zsh/correction

# use .localrc for settings specific to one system
[[ -f ~/.localrc ]] && . ~/.localrc