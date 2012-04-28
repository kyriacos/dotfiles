# PATH and EXPORT VARIABLES
export LESS=-RFX
export SHELL=/bin/zsh
export EDITOR="mvim -v"
#export PATH=~/QtSDK/Simulator/Qt/gcc/bin/:/usr/local/sbin:~/bin:$ZSH/bin:/usr/local/bin:$PATH
export PATH=/usr/local/sbin:~/bin:$ZSH/bin:/usr/local/bin:$PATH
export MANPATH="/usr/local/man:/usr/local/mysql/man:/usr/local/git/man:$MANPATH"
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='3;33'
export VIEW="open" # used by google function to open links in browser

# enable colored output from ls, etc
export LSCOLORS="exfxcxdxbxegedabagacad"
export CLICOLOR=true

# rubygems
export RUBYOPT='rubygems'
export GEM_EDITOR="mvim -v"

# rbenv configuration
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# Ruby gc optimizations
export RUBY_HEAP_MIN_SLOTS=1000000
export RUBY_HEAP_SLOTS_INCREMENT=1000000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
export RUBY_GC_MALLOC_LIMIT=1000000000
export RUBY_HEAP_FREE_MIN=500000
