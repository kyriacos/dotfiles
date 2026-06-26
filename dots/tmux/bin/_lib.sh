# Shared by ~/.tmux/bin scripts (source, do not execute).
[[ -n ${TMUX_BIN:-} ]] && return 0
TMUX_BIN="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
