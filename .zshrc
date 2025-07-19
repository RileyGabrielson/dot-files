# Add deno completions to search path
if [[ ":$FPATH:" != *":/Users/riley.gabrielson/.zsh/completions:"* ]]; then export FPATH="/Users/riley.gabrielson/.zsh/completions:$FPATH"; fi

export ZSH="$HOME/.oh-my-zsh"
export ZSH_THEME="eastwood"
export HYPHEN_INSENSITIVE="true"
export plugins=(git vi-mode yarn)
zstyle ':omz:update' mode reminder

source "$ZSH"/oh-my-zsh.sh
source "$HOME/.tcnrc"

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
 # tmux set -g status off && /usr/local/bin/nvim "$1"
 tmux set -g status off && /opt/homebrew/bin/nvim
 tmux set -g status on
}

fzf-history-widget-accept() {
  fzf-history-widget
  zle accept-line
}

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
alias ls="eza --color=always --long --no-filesize --icons=always --no-time --no-user --no-permissions"
alias merges-since-tag='git log $(git describe --tags --abbrev=0)..HEAD --oneline'
alias ad='aider --model gemini --api-key gemini=$(echo $GEMINI_API_KEY) --no-auto-commits --vim'

# NVM initialisation
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

export DISABLE_UNTRACKED_FILES_DIRTY="true"
export VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true

zle     -N     fzf-history-widget-accept
bindkey '^X^R' fzf-history-widget-accept
[ -f ~/.fzf.zsh ] && source "$HOME/.fzf.zsh"

export FZF_DEFAULT_OPTS="--bind ctrl-n:down,ctrl-p:up"

# bun
[ -s "/Users/riley.gabrielson/.bun/_bun" ] && source "/Users/riley.gabrielson/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"

eval "$(/opt/homebrew/bin/brew shellenv)"

export PATH="/opt/homebrew/opt/node@14/bin:$HOME/.please/:$PATH"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
export PATH="$HOME/go/bin:$PATH"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/riley.gabrielson/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/riley.gabrielson/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/riley.gabrielson/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/riley.gabrielson/google-cloud-sdk/completion.zsh.inc'; fi
