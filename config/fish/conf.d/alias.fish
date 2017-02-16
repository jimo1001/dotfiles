#
# Aliases
#

# tmux
alias tmux='tmux -S ~/tmp/tmux.sock -2u'
function tmux-new-window-ssh
        switch (uname)
                case Darwin
                        set _target (command ssh -G $argv | egrep '^hostname' | awk '{print $2}')
                        command tmux new-window -n "@$_target" ssh -q "$argv"
                case Linux
                        command tmux new-window -n "@$argv[1]" "ssh -q $argv"
        end
end

if [ $TMUX ]
        alias ssh='tmux-new-window-ssh'
        alias nn='tmux new-window'
end

# Python
alias pip-upgrade-all="pip freeze --local | grep -v '^\-e' | cut -d = -f 1 | xargs pip install -U"
alias pip2-upgrade-all="pip2 freeze --local | grep -v '^\-e' | cut -d = -f 1 | xargs pip2 install -U"
alias pip3-upgrade-all="pip3 freeze --local | grep -v '^\-e' | cut -d = -f 1 | xargs pip3 install -U"

# Emacs

alias emacs='emacs -nw'

# Utilities

# Listen Ports
alias netl="sudo lsof -iTCP -sTCP:LISTEN -n -P"
