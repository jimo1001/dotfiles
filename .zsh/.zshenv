#
# Defines environment variables.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Profile
#zmodload zsh/zprof && zprof

# ZDOTDIR
export ZDOTDIR=${HOME}/.zsh

# zplug dir
export ZPLUG_HOME=${HOME}/.zsh/.zplug

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ "$SHLVL" -eq 1 && ! -o LOGIN && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi
