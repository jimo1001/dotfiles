#!/bin/sh

screen -X eval "msgminwait 0" "copy" "stuff \"W\"" "at rdic stuff \"\"" "at rdic paste \".\"" "echo \"looking up in rdic ...\"" "msgminwait 1" "select rdic"
