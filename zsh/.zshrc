# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/agkozak/agkozak-zsh-prompt
ZSH_THEME="agkozak"

HYPHEN_INSENSITIVE="true"
zstyle ':omz:update' mode reminder  # just remind me to update when it's time
plugins=(git zsh-syntax-highlighting zsh-autosuggestions web-search)
source $ZSH/oh-my-zsh.sh

cleanmerged() {
    git branch --merged | egrep -v "(^\*|master|release)" | xargs git branch -D
}

nukenode() {
    rm -rf node_modules ui/payment_portal/node_modules ui/operator/node_modules commons/ui/node_modules tools/ui/frontend-scripts/node_modules && yarn cache clean --all && yarn
}

alias home='cd ~'
alias all='git add -A'
alias com='git commit -m'
alias status='git status'
alias branch='git branch'
alias push='git push'
alias http='npx http-server --cors'
