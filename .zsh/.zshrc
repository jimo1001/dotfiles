#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Customize to your needs...
export PATH="$HOME/bin:/usr/local/bin:/usr/local/sbin:/usr/sbin:/sbin:$PATH"
export MANPATH="/usr/local/man:$MANPATH"

# macOS / Linux
case ${OSTYPE} in
  darwin*)
    export PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"
    # Swift
    export PATH="/Library/Developer/Toolchains/swift-latest.xctoolchain/usr/bin:$PATH"
    # Java
    export JAVA_HOME="/Library/Java/Home"
    # Homebrew
    export HOMEBREW_NO_ANALYTICS=1
    ;;
  linux*)
    # Java
    export JAVA_HOME="/usr/java/latest"
    ;;
esac

# Go
export GOPATH="$HOME/work/goprojects"
export PATH="$PATH:$GOPATH/bin"

# Editor
export EDITOR=vim
export VISUAL=vim

# grep
export GREP_COLOR='1;31'            # BSD.
export GREP_COLORS="mt=$GREP_COLOR" # GNU.

# added by travis gem
[ -f $HOME/.travis/travis.sh ] && source $HOME/.travis/travis.sh

# Virtualenvwrapper
if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
    export WORKON_HOME="$HOME/.virtualenvs"
    source /usr/local/bin/virtualenvwrapper_lazy.sh
fi

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
    source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Source private profile.
if [[ -s "${ZDOTDIR:-$HOME}/private.zsh" ]]; then
    source "${ZDOTDIR:-$HOME}/private.zsh"
fi

# Source alias
if [[ -s "${ZDOTDIR:-$HOME}/.zalias" ]]; then
    source "${ZDOTDIR:-$HOME}/.zalias"
fi

# Display zsh profile
if (type zprof > /dev/null); then
    zprof
fi
