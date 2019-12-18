#
# Defines environment variables.
#

# Zsh Profier
#zmodload zsh/zprof && zprof

# ZDOTDIR
export ZDOTDIR=${HOME}/.zsh

if [[ -d "${ZDOTDIR:-$HOME}/zshenv.d" ]]; then
    for src in $(\ls -1 "${ZDOTDIR:-$HOME}/zshenv.d"); do
        source "${ZDOTDIR:-$HOME}/zshenv.d/$src"
    done
    unset src
fi

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ "$SHLVL" -eq 1 && ! -o LOGIN && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8
