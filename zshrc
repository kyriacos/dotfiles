# shortcut to this $ZSH path is $ZSH
export ZSH=~/.zsh

. $ZSH/config
# wtf?
#. $ZSH/window
. $ZSH/prompt
. $ZSH/aliases
. $ZSH/completion
. $ZSH/correction

# use .localrc for settings specific to one system
[[ -f ~/.localrc ]] && . ~/.localrc

# set the keyboard mode in terminal
set -o emacs # or vi if you prefer

# find out current directory and switch to it
# in new shell window uses escape sequences
# to find out the current directory
precmd () {print -Pn "\e]2; %~/ \a"}
preexec () {print -Pn "\e]2; %~/ \a"}
