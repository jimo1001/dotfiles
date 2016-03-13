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
export PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$HOME/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/share/npm/bin:/usr/local/sbin"
export MANPATH="/usr/local/man:$MANPATH"

# alias
alias tmux='tmux -S ~/tmp/tmux.sock -2u'
alias git=hub
alias swproxy='source ~/.switch_proxyrc'

# JDK-1.8
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_60.jdk/Contents/Home

# Go
export GOPATH=$HOME/work/goprojects
export PATH=$PATH:$GOPATH/bin

# Editor
export EDITOR=vim
export VISUAL=vim

# Grep
export GREP_COLOR='1;31'           # BSD.
export GREP_COLORS="mt=$GREP_COLOR" # GNU.

