. $ZSH/config
. $ZSH/prompt
. $ZSH/aliases
. $ZSH/completion
. $ZSH/correction

# use .localrc for settings specific to one system
[[ -f ~/.localrc ]] && . ~/.localrc

# set the keyboard mode in terminal
set -o emacs # or vi if you prefer

# keep this here as a fix for rake
alias rake='noglob rake'

# http://talkings.org/post/5236392664/zsh-and-slow-git-completion
# superfly tnt git autocomplete
__git_files () {
  _wanted files expl 'local files' _files
}

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
  print -Pn "\e]2; ${PWD/#$HOME/~}\a"
  set_prompt
}
precmd () { set_title_and_prompt }
preexec () { set_title_and_prompt }
