# -*- coding: utf-8 -*-
# .bashrc

pathmunge () {
    if ! echo $PATH | egrep -q "(^|:)$1($|:)" ; then
        if [ "$2" = "after" ] ; then
            PATH=$PATH:$1
        else
            PATH=$1:$PATH
        fi
    fi
}

# Language
export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8

export PS1='\u@\h \t \W \\$ '
export PATH=/opt/local/bin:$PATH
export TERM='xterm-256color'
export LESS='-R'
export LV='-Ou8 -c'

# PATH
pathmunge $HOME/local/bin
pathmunge /usr/local/bin
if [ "$UID" = "0" ]; then
    pathmunge /usr/local/sbin
    pathmunge /usr/sbin
    pathmunge /sbin
fi
export PATH

# Aliases
alias ll='ls -la'
alias ls='ls -FG'
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias ..='cd ..'
alias ...='cd -'

# User specific aliases and functions
stty erase '^H' >& /dev/null
stty stop undef >& /dev/null

# Python
if [ -e "$PYTHONSTARTUP" ]; then
    export PYTHONSTARTUP=$HOME/.pythonrc.py
fi

# Git
export GIT_SSL_NO_VERIFY=true

# Proxy
proxy=""
if [ $proxy ]; then
    export HTTP_PROXY=$proxy
    export http_proxy=$proxy
fi

unset pathmunge
