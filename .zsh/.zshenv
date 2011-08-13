# -*- coding: utf-8; mode: shell-script; -*-
###################################################
# users generic .zshenv file for zsh
###################################################

#--------------------------------------------------
# Environment variable configuration
#--------------------------------------------------

# charactor set
export LANG=ja_JP.UTF-8
# export LANG=ja_JP.EUC-JP

## zsh home directory
export ZDOTDIR=${HOME}/.zsh

## Mail directory
export MAILPATH=$HOME/Mail
export MAIL=$HOME/var/mail

## for ruby
export RUBYLIB=$HOME/lib/ruby/site_ruby/1.8:$HOME/lib/ruby
export GEM_HOME=$HOME/lib/ruby/gem

## w3m HOME
export HTTP_HOME="http://www.google.co.jp/"

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
    export WWW_BROWSER="w3m"
else
    export WWW_BROWSER="firefox"
fi

## Downloader
export DOWNLOADER="wget -S"

## TERM
# export TERM=xterm-256color

#--------------------------------------------------
# Add PATH
#--------------------------------------------------
PATH=${HOME}/local/bin:${HOME}/bin:/opt/local/bin:/usr/local/bin:/bin:/usr/bin:/sw/bin:/usr/local/mysql/bin:$PATH
if [[ $UID = 1 ]]; then
    PATH=/usr/sbin:$PATH
fi
export PATH=$PATH
export MANPATH=$MANPATH:${HOME}/local/man:${HOME}/man:/man:/usr/man:/usr/local/man:/opt/local/man

#--------------------------------------------------
# etc
#--------------------------------------------------

## JAVA for MacOS
if [ `uname` = 'Darwin' ]; then
    JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/1.6/Home
    export JAVA_HOME
    export PATH=${JAVA_HOME}/bin:$PATH
    export TOMCAT_HOME=/usr/local/tomcat6
    export CATALINA_HOME=/usr/local/tomcat6
    export CLASSPATH=$CLASSPATH:$CATALINA_HOME/lib
fi
