#!/bin/bash
# -*- coding: utf-8; mode: shell-script -*-

SCRIPT_FILE=$0
DOTFILE_PATH=${SCRIPT_FILE%/*}

pushd $HOME
ln -is $DOTFILE_PATH/.emacs.d
ln -is $DOTFILE_PATH/.screen
ln -is $DOTFILE_PATH/.zsh
ln -is $DOTFILE_PATH/.bash
ln -is $DOTFILE_PATH/.vim
ln -is $DOTFILE_PATH/.tmux.conf
ln -is $DOTFILE_PATH/.pythonrc.py
ln -is $DOTFILE_PATH/.irbrc
ln -is .screen/.screenrc
ln -is .zsh/.zshenv
ln -is .bash/.bashrc
ln -is .vim/.vimrc
popd
