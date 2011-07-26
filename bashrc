export DOTFILES=~/.dotfiles
. $DOTFILES/bash/env
. $DOTFILES/bash/config
. $DOTFILES/bash/aliases
. $DOTFILES/bash/completions

# use .localrc for settings specific to one system
if [ -f ~/.localrc ]; then
  source ~/.localrc
fi
