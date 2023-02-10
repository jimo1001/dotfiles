# Load fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Use keybindings
zstyle ':prezto:module:fzf' key-bindings 'yes'

# Use completion
zstyle ':prezto:module:fzf' completion 'yes'

# Set height of the fzf results (comment for full screen)
zstyle ':prezto:module:fzf' height '30%'

# Open fzf results in a tmux pane (if using tmux)
zstyle ':prezto:module:fzf' tmux 'yes'

# Set colorscheme
# A list of available colorschemes is available in color.zsh
# To add more color schemes of your own, consult
# https://github.com/junegunn/fzf/wiki/Color-schemes and add values to the
# color.zsh file accordingly
zstyle ':prezto:module:fzf' colorscheme 'Solarized Light'

#export FZF_TMUX=1
bindkey '^/' fzf-file-widget

fzf_git_add() {
    local selected
    selected=$(unbuffer git status -s | fzf -m --ansi --preview="echo {} | awk '{print \$2}' | xargs git diff --color" | awk '{print $2}')
    if [[ -n "$selected" ]]; then
        selected=$(tr '\n' ' ' <<< "$selected")
        git add $selected
        echo "Completed: git add $selected"
    fi
}

zle     -N   fzf_git_add
bindkey '\ea' fzf_git_add
