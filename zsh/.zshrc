#
# Executes commands at the start of an interactive session.
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
    source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# functions
if [[ -d "${ZDOTDIR:-$HOME}/functions" ]]; then
    # Paths
    fpath=(${ZDOTDIR:-$HOME}/functions $fpath)
    # Theme
    autoload prompt_powerline-nerd_setup
    prompt_themes=(powerline-nerd $prompt_themes)
    prompt "powerline-nerd"

    autoload zprezto-update
    autoload pyenv-activate
fi

# Source zshrc
if [[ -d "${ZDOTDIR:-$HOME}/zshrc.d" ]]; then
    for src in $(\ls ${ZDOTDIR:-$HOME}/zshrc.d/); do
        source "${ZDOTDIR:-$HOME}/zshrc.d/$src"
    done
    unset src
fi

# Travis
if [[ -s "$HOME/.travis/travis.sh" ]]; then
    source "$HOME/.travis/travis.sh"
fi

# Display zsh profile
if (type zprof > /dev/null); then
    zprof
fi
