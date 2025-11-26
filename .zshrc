alias k='kubectl'
alias home='cd ~'
alias status='git status'
alias branch='git branch'
alias push='git push'
alias http='npx http-server --cors'
alias vim='nvim'
alias ':q'='exit'
alias lg='lazygit'
alias gl='lazygit'
alias verse='~/verse'
alias s='tmux_sessionizer'
alias a='tmux -2 attach'
alias n='nvim'
alias nvimg="nvim --listen ./godot.pipe"
alias ls="eza --color=always --long"
alias merges-since-tag='git log $(git describe --tags --abbrev=0)..HEAD --oneline'
alias ad='aider --model gemini --api-key gemini=$(echo $GEMINI_API_KEY) --no-auto-commits --vim'

clean-merged() {
  git branch --merged | grep -E -v "(^\*|master|release)" | xargs git branch -D
}

clean-all-for-real() {
  git branch | grep -E -v "(^\*|master|release)" | xargs git branch -D
}

pf() {
  pod=$(kubectl get pods | grep "$1" | head -n 1 | cut -d " " -f 1) && kubectl port-forward "$pod" "$2"
}

nvim() {
 tmux set -g status off && /opt/homebrew/bin/nvim
 tmux set -g status on
}

fzf-history-widget-accept() {
  fzf-history-widget
  zle accept-line
}

present() {
  tmux set -g status off
  presenterm "$@"
  tmux set -g status on
}

export PATH="/opt/homebrew/opt/node@14/bin:$HOME/.please/:$PATH"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

export ZSH="$HOME/.oh-my-zsh"
export ZSH_THEME="eastwood"
export HYPHEN_INSENSITIVE="true"
export plugins=(git vi-mode yarn)
export NVM_DIR="$HOME/.nvm"
export DISABLE_UNTRACKED_FILES_DIRTY="true"
export VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
export FZF_DEFAULT_OPTS="--bind ctrl-n:down,ctrl-p:up,ctrl-d:preview-half-page-down,ctrl-u:preview-half-page-up"
export BUN_INSTALL="$HOME/.bun"
if [[ ":$FPATH:" != *":/Users/riley.gabrielson/.zsh/completions:"* ]]; then export FPATH="/Users/riley.gabrielson/.zsh/completions:$FPATH"; fi

zstyle ':omz:update' mode reminder

source "$ZSH"/oh-my-zsh.sh
source "$HOME/.tcnrc"
source "$HOME/.api.zsh"
[ -f ~/.fzf.zsh ] && source "$HOME/.fzf.zsh"
[ -s "/Users/riley.gabrielson/.bun/_bun" ] && source "/Users/riley.gabrielson/.bun/_bun"
eval "$(/opt/homebrew/bin/brew shellenv)"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
if [ -f '/Users/riley.gabrielson/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/riley.gabrielson/google-cloud-sdk/path.zsh.inc'; fi
if [ -f '/Users/riley.gabrielson/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/riley.gabrielson/google-cloud-sdk/completion.zsh.inc'; fi

zle     -N     fzf-history-widget-accept
bindkey '^X^R' fzf-history-widget-accept
