# -*- coding: utf-8; mode: shell-script; -*-
###################################################
# users generic .zshenv file for zsh
###################################################

pathmunge () {
    if ! echo $PATH | /bin/egrep -q "(^|:)$1($|:)" ; then
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
# export LANG=ja_JP.EUC-JP

## zsh directory
export ZDOTDIR=${HOME}/.zsh

## Mail directory
export MAILPATH=$HOME/Mail
export MAIL=$HOME/var/mail

## for ruby
export RUBYLIB=$HOME/lib/ruby/site_ruby/1.8:$HOME/lib/ruby
export GEM_HOME=$HOME/lib/ruby/gem

## w3m HOME
export HTTP_HOME='http://www.google.co.jp/'

## Editor
if [[ -x `which emacs 2> /dev/null` && `which emacs` != 'emacs not found' ]]; then
    export EDITOR=emacs
elif [[ -x `which vim 2> /dev/null` && `which vim` != 'vim not found' ]]; then
    export EDITOR=vim
elif [[ -x `which vi 2> /dev/null` && `which vi` != 'vi not found' ]]; then
    export EDITOR=vi
fi

## SVN Editor
if [[ -x `which vim 2> /dev/null` && `which vim` != 'vim not found' ]]; then
    export SVN_EDITOR=vim
elif [[ -x `which vi 2> /dev/null` && `which vi` != 'vi not found' ]]; then
    export SVN_EDITOR=vi
elif [[ -x `which emacs 2> /dev/null` && `which emacs` != 'emacs not found' ]]; then
    export SVN_EDITOR=emacs
fi

## Set Pager
if [[ -x `which lv 2> /dev/null` && `which lv` != 'not found' ]]; then
    export PAGER=lv
elif [[ -x `which less 2> /dev/null` && `which less` != 'less not found' ]]; then
    export PAGER=less
fi

## Browser
if [[ -z "$DISPLAY" ]]; then
    export WWW_BROWSER='w3m'
else
    export WWW_BROWSER='firefox'
fi

## Downloader
export DOWNLOADER='wget -S'

## TERM
# export TERM=xterm-256color

# for python
export PYTHONSTARTUP=$HOME/.pythonrc.py

# for Git
export GIT_SSL_NO_VERIFY=true

# LESS
export LESS='-R'

# LV
export LV='-Ou8 -c'

#--------------------------------------------------
# Add PATH
#--------------------------------------------------
pathmunge $HOME/local/bin
pathmunge $HOME/bin
if [ "$UID" = "0" ]; then
    pathmunge /usr/local/sbin
    pathmunge /usr/sbin
    pathmunge /sbin
fi
export PATH
export MANPATH=$MANPATH:$HOME/local/man:$HOME/man:/usr/local/man:/opt/local/man

unset pathmunge
