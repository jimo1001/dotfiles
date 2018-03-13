#
# Defines environment variables.
#

# Zsh Profier
#zmodload zsh/zprof && zprof

# ZDOTDIR
export ZDOTDIR=${HOME}/.zsh

if [[ -d "${ZDOTDIR:-$HOME}/zshenv.d" ]]; then
    for src in $(\ls -1 "${ZDOTDIR:-$HOME}/zshenv.d"); do
        source "${ZDOTDIR:-$HOME}/zshenv.d/$src"
    done
    unset src
fi

# Java
export JAVA_HOME=${JAVA_HOME:-"/Library/Java/Home"}

# Go
export GOPATH=${GOPATH:-"$HOME/work/go"}

# Python
export PYTHONDONTWRITEBYTECODE=1

# for pyenv + pyenv-virtualenv
export PYENV_ROOT=$HOME/.pyenv
export WORKON_HOME=$PYENV_ROOT/versions
export PYENV_VIRTUALENV_DISABLE_PROMPT=1

path=($PYENV_ROOT/{bin,shims} $JAVA_HOME/bin $GOPATH/bin $path)

# pyenv
if which pyenv > /dev/null; then
    eval "$(pyenv init -)"
fi

# pyenv-virtualenv
if which pyenv-virtualenv-init > /dev/null; then
    eval "$(pyenv virtualenv-init -)"
    path=($VIRTUAL_ENV/bin $path)
fi

# Homebrew
export HOMEBREW_NO_ANALYTICS=1

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ "$SHLVL" -eq 1 && ! -o LOGIN && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi
