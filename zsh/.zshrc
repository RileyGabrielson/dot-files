export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="eastwood"

HYPHEN_INSENSITIVE="true"
zstyle ':omz:update' mode reminder
plugins=(git vi-mode yarn)
source $ZSH/oh-my-zsh.sh

cleanmerged() {
    git branch --merged | egrep -v "(^\*|master|release)" | xargs git branch -D
}

pf() {
  pod=$(kubectl get pods | grep $1 | head -n 1 | cut -d " " -f 1) && kubectl port-forward $pod $2
}

alias k='kubectl'
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
alias gl='lazygit'
alias verse='~/verse'
alias s='tmux_sessionizer'
alias nvid='neovide --multigrid'
alias a='tmux attach'
alias n='nvim'

export PATH="/opt/homebrew/opt/node@14/bin:$HOME/.please/:$PATH"

# NVM initialisation
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

DISABLE_UNTRACKED_FILES_DIRTY="true"

VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
source ~/.tcnrc

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/riley.gabrielson/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/riley.gabrielson/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/riley.gabrielson/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/riley.gabrielson/google-cloud-sdk/completion.zsh.inc'; fi

fzf-history-widget-accept() {
  fzf-history-widget
  zle accept-line
}
zle     -N     fzf-history-widget-accept
bindkey '^X^R' fzf-history-widget-accept

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias ls="eza --color=always --long --no-filesize --icons=always --no-time --no-user --no-permissions"
