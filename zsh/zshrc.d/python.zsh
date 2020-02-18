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
fi

