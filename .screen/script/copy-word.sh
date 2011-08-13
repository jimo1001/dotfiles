#!/bin/sh
trap "" SIGHUP ;

Tmp=/tmp/screen-copy-word.`who am I | awk '{print $1}'`

[ ! -p $Tmp ] && ( [ -e $Tmp ] && rm -rf $Tmp ; mkfifo $Tmp )

WAKACHI='mecab -O wakati'
NKF='nkf -Ze'
YOMI='mecab -Oyomi'

screen -X eval "msgminwait 0" \
    "register . ' '" "copy" "stuff 'aW'" "writebuf $Tmp"
word="`sed -e '1d' -e 's/[^[:alnum:],._-]//g' $Tmp`"

if [ -z "$word" ] ; then
    screen -X eval "register . ' '" "copy" "stuff 'a 0 '" "writebuf $Tmp"

    pos="`tr -d '\040-\176' < $Tmp | $NKF `"
    if [ -z "$pos" ] ; then
	screen -X eval "register . ''" "echo 'No word copied'"
	exit
    fi

    screen -X eval "register . ' '" "copy" "stuff 'aY'" "writebuf $Tmp"
    for word in `tr '\040-\176' ' ' < $Tmp | $NKF | $WAKACHI` ; do
	i="$i$word"
	[ ! $pos ">" $i ] && break
    done
fi

case $1 in 
    -j)
    word="`echo \"$word\" | $YOMI | $NKF -h1`"
    ;;
esac

/usr/X11R6/bin/xclipstr "$word" &
screen -X eval "register . '$word'" "echo \"Word \`\`$word\'\' copied into buffer\"" 
