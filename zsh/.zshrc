# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/agkozak/agkozak-zsh-prompt
ZSH_THEME="eastwood"

HYPHEN_INSENSITIVE="true"
zstyle ':omz:update' mode reminder  # just remind me to update when it's time
plugins=(git zsh-autosuggestions web-search )
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
alias vim='nvim'
alias ':q'='exit'
alias vopen='filename=$(fzf); nvim $filename'
alias lg='lazygit'

export PATH="/opt/homebrew/opt/node@14/bin:$HOME/.please/:$PATH"

# NVM initialisation
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

DISABLE_UNTRACKED_FILES_DIRTY="true"
