export BASH=~/.bash
. $BASH/env
. $BASH/config
. $BASH/aliases
. $BASH/completions

# use .localrc for settings specific to one system
if [ -f ~/.localrc ]; then
  source ~/.localrc
fi

# or use hash instead of command -v
[ hash brew 2>/dev/null ] && source "`brew --prefix grc`/etc/grc.bashrc"

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
