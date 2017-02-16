#
# Defines environment variables.
#

# set -x LANG ja_JP.UTF-8
# set -x LC_CTYPE ja_JP.UTF-8
# set -x LC_TIME en_US.UTF-8

# # Java
# set -x JAVA_HOME /Library/Java/Home

# Go
set -x GOPATH $HOME/work/go

# Python
set -x PYENV_ROOT $HOME/.pyenv
. (pyenv init - | psub)
set -x WORKON_HOME $PYENV_ROOT/versions
. (pyenv virtualenv-init - | psub)

# PATH
set -x PATH $JAVA_HOME/bin $GOPATH/bin $PATH

# # Editor
# set -x EDITOR vim
# set -x VISUAL vim

# # grep
# set -x GREP_COLOR '1;31'
# set -x GREP_COLORS "mt=$GREP_COLOR"
# set -x theme_nerd_fonts yes

# # Theme
# set -x theme_display_docker_machine yes
# set -x theme_display_git yes
# set -x theme_color_scheme terminal-dark-black
# set -x theme_nerd_fonts yes
# set -x theme_powerline_fonts yes

# set -x PYTHONDONTWRITEBYTECODE 1
# set -x HOMEBREW_NO_ANALYTICS 1
