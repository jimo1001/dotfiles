#
# alias
#

alias tmux='tmux -S ~/tmp/tmux.sock -2u'

if type hub > /dev/null 2>&1; then
  alias git=hub
fi

if type colordiff > /dev/null 2>&1; then
  alias diff=colordiff
fi

if [ -n "$TMUX" ]; then
    function tmux-new-window-ssh() {
        case $OSTYPE in
            darwin*)
                \tmux new-window -n "$(\ssh -G $@ | awk '$1=="hostname"{if(split($2,a,".")>1){s=a[1]"."a[2]}else{s=a[1]};print "@"s}')" \ssh -q $@
                ;;
            linux*)
                \tmux new-window -n "@$1" "ssh -q $@"
                ;;
        esac
    }
    alias ssh='tmux-new-window-ssh'
    compdef tmux-new-window-ssh='ssh'
fi

alias start-traproxy='sudo launchctl start traproxy'
alias stop-traproxy='sudo launchctl stop traproxy'

# Listen ports
alias netl="sudo lsof -iTCP -sTCP:LISTEN -n -P"

# Python packages
alias pip-upgrade-all="pip freeze --local | grep -v '^\-e' | cut -d = -f 1 | xargs pip install -U"
alias pip2-upgrade-all="pip2 freeze --local | grep -v '^\-e' | cut -d = -f 1 | xargs pip2 install -U"
alias pip3-upgrade-all="pip3 freeze --local | grep -v '^\-e' | cut -d = -f 1 | xargs pip3 install -U"
