#!/bin/sh

TMP=/tmp/screen-copy-line.`who am i | awk '{print $1}'`
trap "" SIGHUP ;

[ -e $TMP ] && rm -rf $TMP ; mkfifo $TMP 

screen -X eval "msgminwait 0" \
    "register . ' '" "copy" "stuff 'a $ '" "writebuf $TMP"

line="`sed -e '1d' $TMP`"

/usr/X11R6/bin/xclipstr "$line" &
screen -X eval "register . '$line'" "echo \"Line copied into buffer\"" 
