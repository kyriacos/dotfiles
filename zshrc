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

# print current directory to title bar
# osx lion now uses that when opening new
# terminal window or tab
# NOTE:
#  - cant figure out the title function yet
#  - also moved precmd and preexec here
#    since i kept forgetting where it was being set
set_title_and_prompt() {
  #title "zsh" "%m" "%55<...<%~"
  #current_directory
  print -Pn "\e]2; %~/ \a"
  set_prompt
}
precmd () { set_title_and_prompt }
preexec () { set_title_and_prompt } 
