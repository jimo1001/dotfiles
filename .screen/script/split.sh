#!/bin/sh

TMPFILE=$HOME/tmp/screen-splited

if [ -f $TMPFILE ]; then
    if [ "$1" = "--toggle" ]; then
	screen -X only
	rm $TMPFILE
	fi
else
    screen -X eval split focus 'resize 8' 'select rdic' focus
    touch $TMPFILE
fi
