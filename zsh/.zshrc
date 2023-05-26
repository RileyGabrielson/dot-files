export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="eastwood"

HYPHEN_INSENSITIVE="true"
zstyle ':omz:update' mode reminder
plugins=(git vi-mode)
source $ZSH/oh-my-zsh.sh

cleanmerged() {
    git branch --merged | egrep -v "(^\*|master|release)" | xargs git branch -D
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
alias gl='lazygit'
alias verse='~/verse'
alias nvid='neovide --multigrid'

alias personal='tmux attach -tpersonal'
alias neo='tmux attach -tneo'
alias legacy='tmux attach -tlegacy'
alias commons='tmux attach -tcommons'
alias plugins='tmux attach -tplugins'
alias ergo='tmux attach -tergo'
alias operator='tmux attach -toperator'

export PATH="/opt/homebrew/opt/node@14/bin:$HOME/.please/:$PATH"

# NVM initialisation
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

DISABLE_UNTRACKED_FILES_DIRTY="true"

VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
if test -f "~/.tcnrc"; then
  source ~/.tcnrc
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/riley.gabrielson/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/riley.gabrielson/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/riley.gabrielson/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/riley.gabrielson/google-cloud-sdk/completion.zsh.inc'; fi

bindkey '^ ' autosuggest-accept
