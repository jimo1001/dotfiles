# setup dot-files

MAKEFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
CURRENT_DIR := $(dir $(MAKEFILE_PATH))

.PHONY: usage
usage:
	@echo "Usage:"
	@echo "      Install: make install"
	@echo "    Uninstall: make uninstall"

# Bash
$(HOME)/.bash:
	/bin/ln -s $(CURRENT_DIR)bash $@

$(HOME)/.bash_profile: $(HOME)/.bash
	cd $(HOME); /bin/ln -s .bash/.bash_profile .

$(HOME)/.bashrc: $(HOME)/.bash
	cd $(HOME); /bin/ln -s .bash/.bashrc .

# Zsh
$(HOME)/.zsh:
	/bin/ln -s $(CURRENT_DIR)zsh $@

$(HOME)/.zshenv: $(HOME)/.zsh
	cd $(HOME); /bin/ln -s .zsh/.zshenv .

$(HOME)/.zsh/.zprezto: $(HOME)/.zsh
	cd $(HOME)/.zsh; git clone --recursive https://github.com/sorin-ionescu/prezto.git .zprezto

$(HOME)/.zsh/.zprezto-contrib/kubectl: $(HOME)/.zsh
	cd $(HOME)/.zsh; git clone https://github.com/prezto-contributions/prezto-kubectl.git .zprezto-contrib/kubectl

$(HOME)/.zsh/.zprezto-contrib/terraform: $(HOME)/.zsh
	cd $(HOME)/.zsh; git clone https://github.com/prezto-contributions/prezto-terraform.git .zprezto-contrib/terraform

$(HOME)/.zsh/.zprezto-contrib/fzf: $(HOME)/.zsh
	cd $(HOME)/.zsh; git clone https://github.com/gpanders/fzf-prezto.git .zprezto-contrib/fzf

# Emacs
$(HOME)/.emacs.d:
	/bin/ln -s $(CURRENT_DIR)emacs.d $@

# Vim
$(HOME)/.vim:
	/bin/ln -s $(CURRENT_DIR)vim $@

$(HOME)/.vimrc: $(HOME)/.vim
	cd $(HOME); /bin/ln -s .vim/.vimrc .

# .config
$(HOME)/.config:
	/bin/ln -s $(CURRENT_DIR)config $@

# tmux
$(HOME)/.tmux.d:
	/bin/ln -s $(CURRENT_DIR)tmux.d $@

$(HOME)/.tmux.conf: $(HOME)/.tmux.d
	cd $(HOME); /bin/ln -s .tmux.d/.tmux.conf .

$(HOME)/.tmux-powerline: $(HOME)/.tmux.d
	cd $(HOME); /bin/ln -s .tmux.d/.tmux-powerlinerc .

# Targets
uninstall:
	@if [ -e $(HOME)/.zsh/.zprezto ]; then \
	  rm -frv $(HOME)/.zsh/.zprezto; \
	fi
	@for p in .zshenv .zsh .bash_profile .bashrc .bash .emacs.d .vimrc .vim .config .tmux.conf .tmux.d; do \
	  if [ -L $(HOME)/$$p ]; then \
	    $(RM) -fv $(HOME)/$$p; \
	  fi \
	done

install: bash zsh emacs vim dotconfig tmux ;

bash: $(HOME)/.bash_profile $(HOME)/.bashrc ;

zsh: $(HOME)/.zshenv $(HOME)/.zsh/.zprezto $(HOME)/.zsh/.zprezto-contrib/kubectl $(HOME)/.zsh/.zprezto-contrib/terraform $(HOME)/.zsh/.zprezto-contrib/fzf ;

emacs: $(HOME)/.emacs.d ;

vim: $(HOME)/.vimrc ;

dotconfig: $(HOME)/.config ;

tmux: $(HOME)/.tmux.conf ;
