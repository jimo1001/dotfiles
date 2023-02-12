# Aliases
alias git-cleanup-branches="git branch -q -l --merged | grep -v '^* ' | grep -v develop | xargs -L1 git branch -d"
alias git-cleanup-unmerged-branches="git branch -q -l --no-merged | grep -v '^* ' | grep -v develop | xargs -L1 git branch -D"

# GPG Signing
export GPG_TTY=$(tty)

