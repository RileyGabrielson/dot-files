# Setup fzf
# ---------
if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/usr/local/opt/fzf/bin"
fi

# Auto-completion
# ---------------
# [[ $- == *i* ]] && source "/opt/homebrew/opt/fzf/shell/completion.zsh" 2> /dev/null

for fzf_shell_dir in /opt/homebrew/opt/fzf/shell /usr/share/doc/fzf/examples; do
  if [[ -d "$fzf_shell_dir" ]]; then
    source "$fzf_shell_dir/key-bindings.zsh"
    [[ -f "$fzf_shell_dir/completion.zsh" ]] && source "$fzf_shell_dir/completion.zsh"
    break
  fi
done
unset fzf_shell_dir

