#!/usr/bin/env bash
# editor-backup.sh
# Backup and restore VS Code and Cursor settings, keybindings, and extensions.
# Usage:
#   ./editor-backup.sh --backup-code   [--dir <path>]
#   ./editor-backup.sh --backup-cursor [--dir <path>]
#   ./editor-backup.sh --restore-code   [--dir <path>]
#   ./editor-backup.sh --restore-cursor [--dir <path>]
#
# Default backup directory: ~/editor-backups

set -euo pipefail

# ── Colours ────────────────────────────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
RESET='\033[0m'

info()    { echo -e "${BLUE}→${RESET} $*"; }
success() { echo -e "${GREEN}✔${RESET} $*"; }
warn()    { echo -e "${YELLOW}⚠${RESET} $*"; }
error()   { echo -e "${RED}✖${RESET} $*" >&2; exit 1; }
header()  { echo -e "\n${BOLD}$*${RESET}"; }

# ── Platform detection ─────────────────────────────────────────────────────────
detect_config_dir() {
  local app="$1"   # "Code" or "Cursor"
  case "$(uname -s)" in
    Darwin)
      echo "$HOME/Library/Application Support/$app/User" ;;
    Linux)
      local dir
      dir=$([ "$app" = "Code" ] && echo "Code" || echo "Cursor")
      echo "$HOME/.config/$dir/User" ;;
    MINGW*|MSYS*|CYGWIN*|Windows_NT)
      echo "$APPDATA/$app/User" ;;
    *)
      error "Unsupported OS: $(uname -s)" ;;
  esac
}

# ── Core helpers ───────────────────────────────────────────────────────────────
backup_editor() {
  local name="$1"      # display name, e.g. "VS Code"
  local app_dir="$2"   # config dir name, e.g. "Code"
  local cmd="$3"       # CLI command, e.g. "code"
  local backup_root="$4"

  header "Backing up $name"

  local config_dir
  config_dir=$(detect_config_dir "$app_dir")
  local dest="$backup_root/$cmd"

  if [ ! -d "$config_dir" ]; then
    error "Config directory not found: $config_dir\nIs $name installed?"
  fi

  mkdir -p "$dest"

  # Settings
  if [ -f "$config_dir/settings.json" ]; then
    cp "$config_dir/settings.json" "$dest/settings.json"
    success "settings.json"
  else
    warn "settings.json not found — skipping"
  fi

  # Keybindings
  if [ -f "$config_dir/keybindings.json" ]; then
    cp "$config_dir/keybindings.json" "$dest/keybindings.json"
    success "keybindings.json"
  else
    warn "keybindings.json not found — skipping"
  fi

  # Extensions
  if command -v "$cmd" &>/dev/null; then
    "$cmd" --list-extensions > "$dest/extensions.txt" 2>/dev/null
    local count
    count=$(wc -l < "$dest/extensions.txt" | tr -d ' ')
    success "extensions.txt ($count extensions)"
  else
    warn "'$cmd' command not found — extensions not backed up"
    warn "Make sure '$cmd' is in your PATH (VS Code/Cursor: Shell Command → Install in PATH)"
  fi

  # Metadata
  echo "backup_date=$(date -u +"%Y-%m-%dT%H:%M:%SZ")" > "$dest/backup.meta"
  echo "os=$(uname -s)" >> "$dest/backup.meta"
  echo "hostname=$(hostname)" >> "$dest/backup.meta"

  success "$name backup complete → $dest"
}

restore_editor() {
  local name="$1"
  local app_dir="$2"
  local cmd="$3"
  local backup_root="$4"

  header "Restoring $name"

  local config_dir
  config_dir=$(detect_config_dir "$app_dir")
  local src="$backup_root/$cmd"

  if [ ! -d "$src" ]; then
    error "Backup not found: $src\nRun --backup-${cmd} first."
  fi

  mkdir -p "$config_dir"

  # Settings
  if [ -f "$src/settings.json" ]; then
    cp "$src/settings.json" "$config_dir/settings.json"
    success "settings.json restored"
  else
    warn "settings.json not in backup — skipping"
  fi

  # Keybindings
  if [ -f "$src/keybindings.json" ]; then
    cp "$src/keybindings.json" "$config_dir/keybindings.json"
    success "keybindings.json restored"
  else
    warn "keybindings.json not in backup — skipping"
  fi

  # Extensions
  if [ -f "$src/extensions.txt" ]; then
    if command -v "$cmd" &>/dev/null; then
      local total failed=0
      total=$(wc -l < "$src/extensions.txt" | tr -d ' ')
      info "Installing $total extensions..."
      while IFS= read -r ext || [ -n "$ext" ]; do
        [ -z "$ext" ] && continue
        if "$cmd" --install-extension "$ext" --force &>/dev/null; then
          echo -e "  ${GREEN}✔${RESET} $ext"
        else
          echo -e "  ${YELLOW}⚠${RESET} $ext (failed — may be unavailable in $name)"
          ((failed++)) || true
        fi
      done < "$src/extensions.txt"
      success "Extensions installed ($((total - failed))/$total succeeded)"
    else
      warn "'$cmd' not in PATH — extensions not installed"
      warn "Install $name, ensure '$cmd' is in PATH, then re-run --restore-${cmd}"
    fi
  else
    warn "extensions.txt not in backup — skipping"
  fi

  # Show backup metadata if present
  if [ -f "$src/backup.meta" ]; then
    echo ""
    info "Backup was created:"
    while IFS='=' read -r key val; do
      printf "  %-15s %s\n" "$key" "$val"
    done < "$src/backup.meta"
  fi

  success "$name restore complete"
}

# ── Argument parsing ───────────────────────────────────────────────────────────
usage() {
  cat <<EOF
${BOLD}editor-backup.sh${RESET} — Backup and restore VS Code / Cursor configs

${BOLD}Usage:${RESET}
  $0 --backup-code    [--dir <path>]
  $0 --backup-cursor  [--dir <path>]
  $0 --restore-code   [--dir <path>]
  $0 --restore-cursor [--dir <path>]

${BOLD}Options:${RESET}
  --dir <path>   Backup directory (default: ~/editor-backups)
  --help         Show this help

${BOLD}What is backed up:${RESET}
  • settings.json
  • keybindings.json
  • Installed extension list

${BOLD}Notes:${RESET}
  • Requires the 'code' / 'cursor' CLI to be in your PATH for extension handling.
  • In VS Code: Command Palette → "Shell Command: Install 'code' command in PATH"
  • In Cursor:  Command Palette → "Shell Command: Install 'cursor' command in PATH"
EOF
  exit 0
}

COMMAND=""
BACKUP_DIR="$HOME/editor-backups"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --backup-code)   COMMAND="backup-code"   ; shift ;;
    --backup-cursor) COMMAND="backup-cursor" ; shift ;;
    --restore-code)  COMMAND="restore-code"  ; shift ;;
    --restore-cursor)COMMAND="restore-cursor"; shift ;;
    --dir)           BACKUP_DIR="$2"         ; shift 2 ;;
    --help|-h)       usage ;;
    *) error "Unknown argument: $1\nRun with --help for usage." ;;
  esac
done

[ -z "$COMMAND" ] && usage

# ── Dispatch ───────────────────────────────────────────────────────────────────
info "Backup directory: $BACKUP_DIR"

case "$COMMAND" in
  backup-code)    backup_editor  "VS Code" "Code"   "code"   "$BACKUP_DIR" ;;
  backup-cursor)  backup_editor  "Cursor"  "Cursor" "cursor" "$BACKUP_DIR" ;;
  restore-code)   restore_editor "VS Code" "Code"   "code"   "$BACKUP_DIR" ;;
  restore-cursor) restore_editor "Cursor"  "Cursor" "cursor" "$BACKUP_DIR" ;;
esac