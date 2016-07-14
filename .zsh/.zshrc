#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
export PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$HOME/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/share/npm/bin:/usr/local/sbin:/usr/sbin:/sbin"
export MANPATH="/usr/local/man:$MANPATH"

# alias
alias tmux='tmux -S ~/tmp/tmux.sock -2u'
alias swproxy='source ~/.switch_proxyrc'
alias update-zprezto='~/.zsh/update-zprezto.sh'
if type hub > /dev/null 2>&1; then
  alias git=hub
fi
if type colordiff > /dev/null 2>&1; then
  alias diff=colordiff
fi
if [ -n "$TMUX" ]; then
  alias ssh='tmux new-window ssh'
fi

# JDK
export JAVA_HOME=/Library/Java/Home

# Go
export GOPATH=$HOME/work/goprojects
export PATH=$PATH:$GOPATH/bin

# Swift
export PATH=/Library/Developer/Toolchains/swift-latest.xctoolchain/usr/bin:$PATH

# Editor
export EDITOR=vim
export VISUAL=vim

# Grep
export GREP_COLOR='1;31'            # BSD.
export GREP_COLORS="mt=$GREP_COLOR" # GNU.

# added by travis gem
[ -f $HOME/.travis/travis.sh ] && source $HOME/.travis/travis.sh

# Homebrew
export HOMEBREW_NO_ANALYTICS=1

# Private
if [[ -s "${ZDOTDIR:-$HOME}/.zprivate" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprivate"
fi

# Virtualenvwrapper
if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
    export WORKON_HOME=$HOME/.virtualenvs
    source /usr/local/bin/virtualenvwrapper_lazy.sh
fi

# show profile
if (which zprof > /dev/null); then
    zprof
fi
