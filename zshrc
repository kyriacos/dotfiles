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

# set the keyboard mode in terminal
set -o emacs # or vi if you prefer

# Ruby gc optimizations
export RUBY_HEAP_MIN_SLOTS=1000000
export RUBY_HEAP_SLOTS_INCREMENT=1000000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
export RUBY_GC_MALLOC_LIMIT=1000000000
export RUBY_HEAP_FREE_MIN=500000

#llvm
export PATH=$PATH:/$LLVMDIR/Release/bin
