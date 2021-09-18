# .bashrc

# Java
export JAVA_HOME=${JAVA_HOME:-"/Library/Java/Home"}

# Go
export GOPATH=${GOPATH:-"$HOME/work/go"}

# Python
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init --path)"
fi
export WORKON_HOME=$PYENV_ROOT/versions
if which pyenv-virtualenv-init > /dev/null; then
    eval "$(pyenv virtualenv-init -)";
fi

# Homebrew
export HOMEBREW_NO_ANALYTICS=1

# PATH
export PATH=$JAVA_HOME/bin:$GOPATH/bin:$WORKON_HOME/bin:$PYENV_ROOT/bin:/usr/local/bin:$PATH

# Editor
export EDITOR=vim
export VISUAL=vim

# grep
export GREP_COLOR='1;31'
export GREP_COLORS="mt=$GREP_COLOR"

# added by travis gem
[ -f /Users/yoshinobu.fujimoto/.travis/travis.sh ] && source /Users/yoshinobu.fujimoto/.travis/travis.sh
