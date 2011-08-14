#!/bin/bash
# -*- coding: utf-8; mode: shell-script -*-

SCRIPT_FILE=$0
DOTFILE_PATH=${SCRIPT_FILE%/*}

ln -sh $DOTFILE_PATH/.emacs.d $HOME/.emacs.d
ln -sh $DOTFILE_PATH/.screen $HOME/.screen
ln -sh $DOTFILE_PATH/.zsh $HOME/.zsh
ln -sh $DOTFILE_PATH/.bash $HOME/.bash
ln -sh $DOTFILE_PATH/.vim $HOME/.vim
ln -s $DOTFILE_PATH/.tmux.conf $HOME/.tmux.conf
ln -s $DOTFILE_PATH/.pythonrc.py $HOME/.pythonrc.py

pushd $HOME
ln -s .screen/.screenrc .screenrc
ln -s .zsh/.zshenv .zshenv
ln -s .bash/.bashrc .bashrc
ln -s .vim/.vimrc .vimrc
popd
