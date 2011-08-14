# -*- coding: utf-8; mode: shell-script; -*-
# User specific aliases and functions
export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8

stty stop undef

# for python
export PYTHONSTARTUP=$HOME/.pythonrc.py
export PYTHONPATH=/var/service/python/lib/python2.6/site-packages

# for Git
export GIT_SSL_NO_VERIFY=true

# TERM
export TERM=xterm-256color


# $URL: file:///home/ryo/svn/zshconf/trunk/dot.zprofile $
# $Id: dot.zprofile 2 2006-02-27 16:31:19Z ryo $
echo "Loading .zprofile"

### Select OS type

case $OSTYPE {
  sunos*)export SYSTEM=sun ;;
  solaris*)export SYSTEM=sol ;;
  irix*)export SYSTEM=sgi ;;
  osf*)export SYSTEM=dec ;;
  linux*)export SYSTEM=gnu ;;
  freebsd*)export SYSTEM=bsd ;;
  darwin*)export SYSTEM=darwin ;;    # MacOSX
}

# ZDOTDIR は zsh の個人用設定ファイルを探すディレクトリを指定する

if [ -z $ZDOTDIR ]; then
  export ZDOTDIR=${HOME}/.zsh
fi

# 切り分けた設定ファイルを読み込むディレクトリを指定する

export ZUSERDIR=$ZDOTDIR


### System specific environment

# 環境変数（PATH など）の OS 別設定ファイルを読み込む

if [ -f $ZUSERDIR/$SYSTEM.zshrc ]; then
  source $ZUSERDIR/$SYSTEM.zshrc
fi

# man path
export MANPATH="$MANPATH:/usr/local/man:$HOME/man:"

### environment variables

# 共通する環境変数を設定する

#export LESSCHARSET=japanese-euc
export LESSCHARSET=japanese
#export LESS='-irqMM'
export LESS='-iqMM'
unset  LESSOPEN
export GZIP='-v9N'
export XMODIFIERS=@im=kinput2
#export XMODIFIERS=@im=_XWNMO
