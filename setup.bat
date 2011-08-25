@echo off

set DOTFILE_PATH=%~dp0
set CURRENT_PATH=%CD%

mklink /D "%HOME%/.emacs.d" "%DOTFILE_PATH%/.emacs.d"
mklink /D "%HOME%/.screen" "%DOTFILE_PATH%/.screen"
mklink /D "%HOME%/.zsh" "%DOTFILE_PATH%/.zsh"
mklink /D "%HOME%/.bash" "%DOTFILE_PATH%/.bash"
mklink /D "%HOME%/.vim" "%DOTFILE_PATH%/.vim"
mklink "%HOME%/.tmux.conf" "%DOTFILE_PATH%/.tmux.conf"
mklink "%HOME%/.pythonrc.py" "%DOTFILE_PATH%/.pythonrc.py"

cd "%HOME%"
mklink .screenrc .screen\.screenrc
mklink .zshenv .zsh\.zshenv
mklink .bash_profile .bash\.bash_profile
mklink .bashrc .bash\.bashrc
mklink .vimrc .vim\.vimrc
cd "%CURRENT_PATH%"
