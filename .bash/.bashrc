# -*- coding: utf-8 -*-

export PS1='\u@\h \t \W \\$ '
export PATH=/opt/local/bin:$PATH
export TERM='xterm-256color'
export LESS='-R'
export LV='-Ou8 -c'

# aliases
alias ll='ls -la'
alias ls='ls -F --color=always'
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias ..='cd ..'
alias ...='cd -'

# User specific aliases and functions
stty erase '^H' >& /dev/null
stty stop undef >& /dev/null

# for python
export PYTHONSTARTUP=$HOME/.pythonrc.py

# for Git
export GIT_SSL_NO_VERIFY=true
