# shortcut to this $ZSH path is $ZSH
export ZSH=$HOME/.dotfiles

. $ZSH/zsh/config
. $ZSH/zsh/aliases
. $ZSH/zsh/completion

# use .localrc for settings specific to one system
[[ -f ~/.localrc ]] && . ~/.localrc