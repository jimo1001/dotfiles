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

alias la='ls -A'
alias lal='ls -Al'

# Listen ports
alias netl="sudo lsof -iTCP -sTCP:LISTEN -n -P"

# Python packages
alias update-python-packages="pip list -o -l --format freeze | cut -d = -f 1 | xargs -n 1 pip install -U"

# Emacs
alias emacs="reattach-to-user-namespace emacs -nw"
# Update packages
alias update-emacs-packages="emacs --batch -l ~/.emacs.d/init.el --eval \"(progn (require 'package-utils)(package-utils-upgrade-all)(package-autoremove))\""

# Git-Crypt
alias git-crypt="LANG=C LC_ALL=C git-crypt"

# Terraform
alias t11="/usr/local/opt/terraform@0.11/bin/terraform"
alias t12="/usr/local/opt/terraform@0.12/bin/terraform"
alias t="terraform"

# Kubernetes
alias k="kubectl"

# UUID
alias uuid="uuidgen | tr -d '\n' | tr '[:upper:]' '[:lower:]'  | pbcopy && pbpaste && echo"

# Git
alias git-clean-branches="git branch -q -l | grep -v master | grep -v main | grep -v develop | xargs -L1 git branch -d"
