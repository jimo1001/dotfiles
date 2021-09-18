export PYTHONDONTWRITEBYTECODE=1

# for pyenv + pyenv-virtualenv
export PYENV_ROOT=$HOME/.pyenv
export WORKON_HOME=$PYENV_ROOT/versions
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PATH="$PYENV_ROOT/bin:$PATH"

path=($PYENV_ROOT/{bin,shims} $JAVA_HOME/bin $GOPATH/bin $path)

# pyenv
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
fi

# pyenv-virtualenv
if which pyenv-virtualenv-init > /dev/null; then
    eval "$(pyenv virtualenv-init -)"
fi

