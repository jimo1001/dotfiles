# -*- coding: utf-8; mode: shell-script; -*-
###################################################
# users generic .zlogin file for zsh
###################################################

# wipe out dead screens
#if [ -x `which screen 2> /dev/null` ]; then
#  screen -q -wipe
#fi

# display (or not) messages from other users
mesg y

# show system status
# uptime
# echo '-----------------------------------------------------------------'

# echo "Welcome to '${HOST}' !"
# #echo "\t-> OS is `uname -rs`."
# perl -e 'chomp($u=qx(uname -rs));printf "\t-> OS is %s.\n", $u'
# perl -e '($t=qx(ac))=~s/^.*?(\d+?)\..*?$/$1/;printf"\t-> Your total login time is about %d day %d hrs.\n",int($t/24),int($t%24)'
# echo '-----------------------------------------------------------------'
# who | sort
# echo '-----------------------------------------------------------------'

# execute when screen.
# get num of unread mail.
# if [ ${GNU_SCREEN} ]; then
#     if [ -x `which getmailcount.rb 2> /dev/null` ]; then
# 	exec getmailcount.rb &
#     fi

# get num of unread feed.
#     if [ -x `which getfeedcount.rb 2> /dev/null` ]; then
# 	exec getfeedcount.rb &
#     fi
# fi

# # launch ssh-agent1
# eval `ssh-agent -c`
# ssh-add ~/.ssh/id_dsa
