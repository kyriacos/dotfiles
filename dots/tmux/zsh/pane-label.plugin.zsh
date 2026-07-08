# Auto-label tmux pane borders (see ~/.tmux/README).
# Manual window rename: prefix+, or `twname my-label`.

tmux_pane_label() {
  [[ -z ${TMUX:-} ]] && return 0
  "$HOME/.tmux/bin/pane-rename" 2>/dev/null
}

twname() {
  [[ -z ${TMUX:-} || -z ${1:-} ]] && return 1
  command tmux rename-window "$1" 2>/dev/null
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd tmux_pane_label
add-zsh-hook preexec tmux_pane_label
chpwd_functions+=(tmux_pane_label)
