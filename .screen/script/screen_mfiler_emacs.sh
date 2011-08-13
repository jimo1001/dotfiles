#!/bin/sh

if [ $GNU_SCREEN = true -a $# = 1 ]; then
    screen -r -X select 0
    emacsclient -n $1 &
else
    /usr/local/bin/emacs $@
fi
