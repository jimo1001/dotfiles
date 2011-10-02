# -*- coding: utf-8; mode: shell-script; -*-

#stty stop undef

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
