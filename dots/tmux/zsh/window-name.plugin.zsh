# Auto-rename tmux window + pane labels (see ~/.tmux/README).
# Custom window names: prefix+, or `twname my-label`. Reset with `twname -r`.

tmux_auto_label() {
  [[ -z ${TMUX:-} ]] && return 0
  command auto-label 2>/dev/null
}

tmux_window_rename() {
  tmux_auto_label
}

twname() {
  [[ -z ${TMUX:-} ]] && return 1

  if [[ ${1:-} == -r || ${1:-} == --reset ]]; then
    command tmux set -wug @manual_window_name 2>/dev/null
    tmux_window_rename
    return 0
  fi

  [[ -z ${1:-} ]] && return 1
  command tmux set -w @manual_window_name "$1" 2>/dev/null
  command tmux rename-window "$1" 2>/dev/null
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd tmux_window_rename
add-zsh-hook preexec tmux_window_rename
chpwd_functions+=(tmux_window_rename)
