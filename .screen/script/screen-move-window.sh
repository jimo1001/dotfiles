#!/bin/sh

case $1 in 
    forward)
    OTHER=`expr $WINDOW + 1`
    ;;
    
    backward)
    OTHER=`expr $WINDOW - 1`
    ;;
esac

screen -X eval "number $OTHER" "echo \"Current window moved $1\""
