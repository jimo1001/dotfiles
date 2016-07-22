MAKEFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
CURRENT_DIR := $(dir $(MAKEFILE_PATH))

all: zsh emacs python tmux git

clean:
	rm -frv $(HOME)/.zsh/.zprezto
	if [ -L $(HOME)/.zshenv ]; then unlink $(HOME)/.zshenv; fi
	if [ -L $(HOME)/.zsh ]; then unlink $(HOME)/.zsh; fi
	if [ -L $(HOME)/.emacs.d ]; then unlink $(HOME)/.emacs.d; fi
	if [ -L $(HOME)/.vim ]; then unlink $(HOME)/.vim; fi
	if [ -L $(HOME)/.ipython ]; then unlink $(HOME)/.ipython; fi
	if [ -L $(HOME)/.config ]; then unlink $(HOME)/.config; fi
	if [ -L $(HOME)/.tmux.conf ]; then unlink $(HOME)/.tmux.conf; fi
	if [ -L $(HOME)/.tmux-powerlinerc ]; then unlink $(HOME)/.tmux-powerlinerc; fi
	if [ -L $(HOME)/.tmux.d ]; then unlink $(HOME)/.tmux.d; fi
	if [ -L $(HOME)/.gitconfig ]; then unlink $(HOME)/.gitconfig; fi


# zsh
zsh: $(HOME)/.zsh $(HOME)/.zshenv $(HOME)/.zsh/.zprezto

$(HOME)/.zsh:
	/bin/ln -s $(CURRENT_DIR).zsh $(HOME)/.zsh

$(HOME)/.zshenv:
	cd $(HOME); /bin/ln -s .zsh/.zshenv .

$(HOME)/.zsh/.zprezto: $(HOME)/.zsh
	git clone --recursive https://github.com/sorin-ionescu/prezto.git $(HOME)/.zsh/.zprezto


# Emacs
emacs: $(HOME)/.emacs.d

$(HOME)/.emacs.d:
	/bin/ln -s $(CURRENT_DIR).emacs.d $(HOME)/.emacs.d


# Vim
vim: $(HOME)/.vim

$(HOME)/.vim:
	/bin/ln -s $(CURRENT_DIR).vim $(HOME)/.vim


# Python
python: $(HOME)/.ipython $(HOME)/.config

$(HOME)/.ipython:
	/bin/ln -s $(CURRENT_DIR).ipython $(HOME)/.ipython

$(HOME)/.config:
	/bin/ln -s $(CURRENT_DIR).config $(HOME)/.config


# tmux
tmux: $(HOME)/.tmux.d $(HOME)/.tmux.conf $(HOME)/.tmux-powerline

$(HOME)/.tmux.d:
	/bin/ln -s $(CURRENT_DIR).tmux.d $(HOME)/.tmux.d

$(HOME)/.tmux.conf: $(HOME)/.tmux.d
	cd $(HOME); /bin/ln -s .tmux.d/.tmux.conf .

$(HOME)/.tmux-powerline: $(HOME)/.tmux.d
	cd $(HOME); /bin/ln -s .tmux.d/.tmux-powerlinerc .


# Git
git: $(HOME)/.gitconfig

$(HOME)/.gitconfig:
	/bin/ln -s $(CURRENT_DIR).gitconfig $(HOME)/.gitconfig


