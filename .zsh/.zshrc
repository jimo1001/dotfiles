# -*- coding: utf-8; mode: shell-script; -*-
###################################################
# users generic .zshrc file for zsh
###################################################

#--------------------------------------------------
# load user .zshrc configuration file
#--------------------------------------------------
[ -f $ZDOTDIR/.zshrc.mine ] && source $ZDOTDIR/.zshrc.mine
[ -f $ZDOTDIR/.zaliases ] && source $ZDOTDIR/.zaliases
if [ -d ~/lib/zsh/functions ]; then
    fpath=(~/lib/zsh/functions $fpath)
fi

#--------------------------------------------------
# Environment variable configuration
#--------------------------------------------------

## swich [ Downloader or Browser
if autoload +X -U _accept_line_with_url > /dev/null 2>&1; then
    zle -N accept-line-with-url _accept_line_with_url
    bindkey '^M' accept-line-with-url
    bindkey '^J' accept-line-with-url
fi
browse_or_download_method="auto"

## up directory
WORDCHARS='*?_-.[]~&;!#$%^(){}<>'

#--------------------------------------------------
# davvrev :copy completion strings in screen
#--------------------------------------------------
if [ ! -d $HOME/tmp ]; then
    mkdir $HOME/tmp
fi
if [ ! -f $HOME/tmp/screen-hardcopy ]; then
    touch $HOME/tmp/screen-hardcopy
fi
if [ -f $HOME/tmp/screen-hardcopy ]; then
    HARDCOPYFILE=$HOME/tmp/screen-hardcopy
fi
dabbrev-complete () {
        local reply lines=80 # 80行分
        screen -X eval "hardcopy -h $HARDCOPYFILE"
        reply=($(sed '/^$/d' $HARDCOPYFILE | sed '$ d' | tail -$lines))
        compadd - "${reply[@]%[*/=@|]}"
}

zle -C dabbrev-complete menu-complete dabbrev-complete
bindkey '^o' dabbrev-complete
bindkey '^o^_' reverse-menu-complete

#--------------------------------------------------
# vcs info
#--------------------------------------------------
autoload -Uz add-zsh-hook
autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git svn hg bzr
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'
zstyle ':vcs_info:bzr:*' use-simple true

autoload -Uz is-at-least
if is-at-least 4.3.10; then
  # この check-for-changes が今回の設定するところ
  zstyle ':vcs_info:git:*' check-for-changes true
  zstyle ':vcs_info:git:*' stagedstr "+"    # 適当な文字列に変更する
  zstyle ':vcs_info:git:*' unstagedstr "-"  # 適当の文字列に変更する
  zstyle ':vcs_info:git:*' formats '(%s)-[%c%u%b]'
  zstyle ':vcs_info:git:*' actionformats '(%s)-[%c%u%b|%a]'
fi

function _update_vcs_info_msg() {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    psvar[2]=$(_git_not_pushed)
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
add-zsh-hook precmd _update_vcs_info_msg

function _git_not_pushed()
{
  if [ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = "true" ]; then
    head="$(git rev-parse HEAD)"
    for x in $(git rev-parse --remotes)
    do
      if [ "$head" = "$x" ]; then
        return 0
      fi
    done
    echo "{?}"
  fi
  return 0
}

#--------------------------------------------------
# Default shell configuration
#--------------------------------------------------
# set prompt
autoload colors
colors

## number of color --------------------------------
# 0   to restore default color
# 1   for brighter colors
# 4   for underlined text
# 5   for flashing text
# 30  for black foreground
# 31  for red foreground
# 32  for green foreground
# 33  for yellow (or brown) foreground
# 34  for blue foreground
# 35  for purple foreground
# 36  for cyan foreground
# 37  for white (or gray) foreground
# 40  for black background
# 41  for red background
# 42  for green background
# 43  for yellow (or brown) background
# 44  for blue background
# 45  for purple background
# 46  for cyan background
# 47  for white (or gray) background
local DEFAULT='%{[m%}'
local RED='%{[1;31m%}'
local GREEN='%{[1;32m%}'
local YELLOW='%{[1;33m%}'
local BLUE='%{[1;34m%}'
local PURPLE='%{[1;35m%}'
local CYAN='%{[1;36m%}'
local WHITE='%{[1;37m%}'
##-------------------------------------------------

## prompt
if [ ${TERM} = "dumb" ]; then
    # for emacs
    PROMPT="%n@%m[%D %T]$ "
else
case ${UID} in
0)
  PROMPT="${YELLOW}%n${DEFAULT}@${YELLOW}%m${DEFAULT} %D %T ${YELLOW}#${DEFAULT} "
  PROMPT2="${YELLOW}%_%%${DEFAULT} "
  RPROMPT="[${YELLOW}%~${DEFAULT}]"
  SPROMPT="${LIGHT_BLUE}%r is correct? [n,y,a,e]:${DEFAULT} "
  [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
  ;;
*)
  PROMPT="${GREEN}%n${DEFAULT}@${GREEN}%m${DEFAULT} %D %T ${GREEN}\$${DEFAULT} "
  PROMPT2="${YELLOW}%_%%${DEFAULT} "
  RPROMPT="%1(v|%F${CYAN}%1v%2v%f|)${vcs_info_git_pushed}${RESET}${WHITE}[${BLUE}%(5~,%-2~/.../%2~,%~)% ${WHITE}]${WINDOW:+"[$WINDOW]"} ${RESET}"
  #RPROMPT="[${GREEN}%~${DEFAULT}]"
  SPROMPT="${LIGHT_BLUE}%r is correct? [n,y,a,e]:${DEFAULT} "
  [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
  ;;
# 0)
#   PROMPT="${YELLOW}#:----(${DEFAULT} ${LIGHT_BLUE}%n${DEFAULT}${RED}@${DEFAULT}${GREEN}%m${DEFAULT}${DEFAULT} ${YELLOW})----(${DEFAULT} ${PURPLE}%D %T${DEFAULT} ${YELLOW})-----(${DEFAULT} ${LIGHT_BLUE}%~${DEFAULT} ${YELLOW})${DEFAULT}
# ${YELLOW}#:-->${DEFAULT} "
#   PROMPT2="${YELLOW}%_%%${DEFAULT} "
# #   RPROMPT="${LIGHT_BLUE}[%~]${DEFAULT}"
#   SPROMPT="${LIGHT_BLUE}%r is correct? [n,y,a,e]:${DEFAULT} "
#   [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
#   ;;
# *)
#   PROMPT="${YELLOW}$:----(${DEFAULT} ${LIGHT_BLUE}%n${DEFAULT}${RED}@${DEFAULT}${GREEN}%m${DEFAULT}${DEFAULT} ${YELLOW})----(${DEFAULT} ${PURPLE}%D %T${DEFAULT} ${YELLOW})-----(${DEFAULT} ${LIGHT_BLUE}%~${DEFAULT} ${YELLOW})${DEFAULT}
# ${YELLOW}$:-->${DEFAULT} "
#   PROMPT2="${YELLOW}%_%%${DEFAULT} "
# #   RPROMPT="${LIGHT_BLUE}[%~]${DEFAULT}"
#   SPROMPT="${LIGHT_BLUE}%r is correct? [n,y,a,e]:${DEFAULT} "
#   [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
#   ;;
esac
fi

## emacs shell-mode
[[ $EMACS = t ]] && unsetopt zle

## use color
setopt prompt_subst

## auto change directory
setopt auto_cd

## auto directory pushd that you can get dirs list by cd -[tab]
# setopt auto_pushd

## command correct edition before each completion attempt
setopt correct

## compacked complete list display
setopt list_packed

## no remove postfix slash of command line
setopt noautoremoveslash

## no beep sound when complete list displayed
setopt nolistbeep

## multi os
setopt multios

## no beep
setopt no_beep

## mark /
setopt mark_dirs

## echo 8bit wards
setopt print_eight_bit

## C-s, C-q invalid
setopt no_flow_control

## directory color
export LS_DOLORS=$BLUE

## list (^I)
setopt auto_list

## after '='
setopt magic_equal_subst

## option, limit, bindkey
setopt hist_reduce_blanks

## ignore duplication command history list
setopt hist_ignore_dups

# Ctrl+D では終了しないようになる（exit, logout などを使う）
setopt ignore_eof

# シェルが終了しても裏ジョブに HUP シグナルを送らないようにする
setopt NO_hup

## head space
setopt hist_ignore_space

## share command history data
setopt share_history

## When using more than one zsh at the same time, it isn't overwritten and is added in a history file.
setopt append_history

# ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash

# 補完候補一覧でファイルの種別を識別マーク表示 (訳注:ls -F の記号)
# setopt list_type

# 補完キー連打で順に補完候補を自動で補完
# setopt auto_menu

# カッコの対応などを自動的に補完
setopt auto_param_keys

# コマンドラインでも # 以降をコメントと見なす
setopt interactive_comments

# コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる
setopt magic_equal_subst

# 語の途中でもカーソル位置で補完
setopt complete_in_word

# カーソル位置は保持したままファイル名一覧を順次その場で表示
setopt always_last_prompt

#日本語ファイル名等8ビットを通す
setopt print_eight_bit

# 拡張グロブで補完(~とか^とか。例えばless *.txt~memo.txt ならmemo.txt 以外の *.txt にマッチ)
setopt extended_glob

# 明確なドットの指定なしで.から始まるファイルをマッチ
setopt globdots

# # 展開する前に補完候補を出させる(Ctrl-iで補完するようにする)
# bindkey "^I" menu-complete

## Recording time to the past record file
# setopt extended_history

## tetris
autoload -U tetris; zle -N tetris

#--------------------------------------------------
# Keybind configuration
#--------------------------------------------------
# emacs like keybind (e.x. Ctrl-a goes to head of a line and Ctrl-e goes
# to end of it)
bindkey -e

# historical backward/forward search with linehead string binded to ^P/^N
#
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end

#--------------------------------------------------
# Command history configuration
#--------------------------------------------------
HISTFILE=$HOME/tmp/.zhistory
HISTSIZE=10000
SAVEHIST=10000
# function history-all { history -E 1 }

#--------------------------------------------------
# Completion configuration
#--------------------------------------------------
fpath=($ZDOTDIR/completion ${fpath})
autoload -Uz compinit
compinit -u

#--------------------------------------------------
# Abbreviation
#--------------------------------------------------
typeset -A myabbrev
myabbrev=(
    "ll" "| ${PAGER}"
    "lg" "| grep"
    "tx" "tar -xvzf"
    "sr" "screen -U -r"
    "ss" "screen -U -S"
    "sx" "screen -r -X"
    "ta" "tmux attach"
    "em" "emacs -nw")

my-expand-abbrev() {
    local left prefix
    left=$(echo -nE "$LBUFFER" | sed -e "s/[_a-zA-Z0-9]*$//")
    prefix=$(echo -nE "$LBUFFER" | sed -e "s/.*[^_a-zA-Z0-9]\([_a-zA-Z0-9]*\)$/\1/")
    LBUFFER=$left${myabbrev[$prefix]:-$prefix}" "
}
zle -N my-expand-abbrev
bindkey     " "         my-expand-abbrev

#--------------------------------------------------
# terminal configuration
#--------------------------------------------------

unset LSCOLORS
case "${TERM}" in
xterm)
  export TERM=xterm-color
  ;;
kterm)
  export TERM=kterm-color
  # set BackSpace control character
  stty erase
  ;;
cons25)
  export LSCOLORS='GxFxCxdxBxexexhxBxBxBx'
  export LS_COLORS='di=01;36:ln=01;35:so=01;32:ex=01;31:bd=01;36:cd=01;36:su=01;31:sg=01;31:tw=01;31:ow=01;31'
  zstyle ':completion:*' list-colors \
    'di=;36;1' 'ln=;35;1' 'so=;32;1' 'ex=;31;1' 'bd=;36;1' 'cd=;36;1'
  ;;
*)
  export LSCOLORS='GxFxCxdxBxexexhxBxBxBx'
  export LS_COLORS='di=01;36:ln=01;35:so=01;32:ex=01;31:bd=01;36:cd=01;36:su=01;31:sg=01;31:tw=01;31:ow=01;31'
  zstyle ':completion:*' list-colors \
    'di=;36;1' 'ln=;35;1' 'so=;32;1' 'ex=;31;1' 'bd=;36;1' 'cd=;36;1'
  ;;
esac

## set terminal title including current directory
case "${TERM}" in
kterm*|xterm*)
  precmd() {
    echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
  }
  export LSCOLORS='GxFxCxdxBxexexhxBxBxBx'
  export LS_COLORS='di=01;36:ln=01;35:so=01;32:pi=01;33:ex=01;31:bd=46;36:cd=43;36:su=41;31:sg=46;31:tw=42;31:ow=43;31'
  zstyle ':completion:*' list-colors \
    'di=01;36' 'ln=01;35' 'so=01;32' 'ex=01;31' 'bd=46;36' 'cd=43;36'
  ;;
esac
# The supplementation candidate can be selected with the cursor.
zstyle ':completion:*:default' menu select=1
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                             /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:messages' format $YELLOW'%d'$DEFAULT
zstyle ':completion:*:warnings' format $RED'No matches for:'$YELLOW' %d'$DEFAULT
zstyle ':completion:*:descriptions' format $YELLOW'completing %B%d%b'$DEFAULT
zstyle ':completion:*:corrections' format $YELLOW'%B%d '$RED'(errors: %e)%b'$DEFAULT
zstyle ':completion:*:options' description 'yes'
# グループ名に空文字列を指定すると，マッチ対象のタグ名がグループ名に使われる。
# したがって，すべての マッチ種別を別々に表示させたいなら以下のようにする
zstyle ':completion:*' group-name ''
zstyle ':completion:*:*files' ignored-patterns '*?.o' '*?~' '*\#'
zstyle ':completion:*' use-cache true
zstyle ':completion:*' list-separator '-->'
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters
zstyle ':completion:*:manuals' separate-sections true

#--------------------------------------------------
# auto complementarity
#--------------------------------------------------
# autoload predict-on
# predict-on

#--------------------------------------------------
# complete Host
#--------------------------------------------------
_cache_hosts=(
 localhost
 $HOST
)

# if [ $GNU_SCREEN ]; then
#  source $HOME/.zsh/.zsh_screen
# fi

# Completion plugin
#source .zsh/plugin/incr*.zsh
