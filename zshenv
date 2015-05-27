# shortcut to this $ZSH path is $ZSH
export ZSH=~/.zsh
# PATH and EXPORT VARIABLES
export LESS=-RFX
#export SHELL=/bin/zsh
export SHELL=/usr/local/bin/zsh

export PATH=/usr/local/bin:/usr/local/sbin:./bin:/usr/sbin::~/bin:$ZSH/bin:$PATH
# bundler binstubs i.e. execute rspec without bundle exec
export PATH="./bin:$PATH"

# add ./node_modules/.bin/ to path
export PATH="./node_modules/.bin:$PATH"

# java home
export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)

# brew cask
export HOMEBREW_CASK_OPTS="--appdir=/Applications" # install cask apps to /Applications

# rvm config (do it here otherwise it fucks up my binstubs
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
export PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

export MANPATH="/usr/local/man:/usr/local/mysql/man:/usr/local/git/man:$MANPATH"
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='3;33'
export VIEW="open" # used by google function to open links in browser

# enable colored output from ls, etc
export LSCOLORS="exfxcxdxbxegedabagacad"
export LS_COLORS="di=1;;40:ln=35;40:so=32;40:pi=33;40:ex=33;40:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:"
export CLICOLOR=true

# editor
export EDITOR="mvim -v"
export GIT_EDITOR="mvim -v"

# rubygems
export GEM_EDITOR="mvim -v"

# rbenv configuration
rbenv_exist=$(command -v rbenv >/dev/null 2>&1)
if [[ $rbenv_exist != "" ]]
then
  export PATH="$HOME/.rbenv/bin":$PATH
  eval "$(rbenv init -)"
fi

# Ruby gc optimizations
export RUBY_GC_HEAP_INIT_SLOTS=100000
export RUBY_HEAP_SLOTS_INCREMENT=1000000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
export RUBY_GC_MALLOC_LIMIT=1000000000
export RUBY_HEAP_FREE_MIN=500000
