# ass — AI Session Search

Fuzzy-search your local AI chat history across **Claude Code** and **Cursor** from the terminal. Preview conversations with syntax-highlighted code blocks, filter by tool, and resume sessions with a single keypress.

---

## Requirements

| Tool | Purpose | Install |
|------|---------|---------|
| [fzf](https://github.com/junegunn/fzf) >= 0.45 | Fuzzy picker (`become` action) | `brew install fzf` |
| [bat](https://github.com/sharkdp/bat) | Code block syntax highlighting | `brew install bat` |
| Python 3 | Session parsing (stdlib only) | ships with macOS / most Linux |
| [Claude Code](https://claude.ai/code) | Claude sessions + `claude --resume` | `npm i -g @anthropic-ai/claude-code` |
| [Cursor](https://cursor.com) | Cursor sessions + `cursor --reuse-window` | download from cursor.com |

**Supported OS:** macOS and Linux. Windows is not supported.

---

## Installation

```bash
# 1. Copy the script somewhere on your PATH
cp ass ~/.local/bin/ass
chmod +x ~/.local/bin/ass

# Or symlink it if you cloned this repo
ln -sf "$(pwd)/ass" ~/.local/bin/ass
```

---

## Usage

```bash
ass
```

Opens the picker. Sessions are sorted newest-first and colour-coded by source:

- **cyan** — Claude Code
- **yellow** — Cursor

### Key bindings

| Key | Action |
|-----|--------|
| `F1` | Show Claude Code sessions only |
| `F2` | Show Cursor sessions only |
| `F3` | Show all sessions (reset filter) |
| `F5` | Resume selected session |
| `Enter` | Print session identifier to stdout |
| `Ctrl-C` | Cancel |

**F5 resume behaviour:**

- Claude Code → runs `claude --resume <uuid>` in the current terminal
- Cursor → runs `cursor --reuse-window <workspace-path>` (opens the GUI)

### Scripting

```bash
# Resume a Claude session directly (non-interactive)
claude --resume "$(basename "$(ass)" .jsonl)"

# Open the raw session file in your editor
$EDITOR "$(ass)"
```

---

## How it works

**Claude Code** stores sessions as JSONL files:

```
~/.claude/projects/<encoded-path>/<uuid>.jsonl
```

Each line is a JSON event; messages live at `obj.message.role` / `obj.message.content`. The project folder name is the workspace path with `/` and `.` replaced by `-` — the script reverses this to produce a readable label.

**Cursor** stores sessions in SQLite:

```
# macOS
~/Library/Application Support/Cursor/User/globalStorage/state.vscdb

# Linux
~/.config/Cursor/User/globalStorage/state.vscdb
```

Conversations are keyed as `composerData:<composerId>` and individual messages as `bubbleId:<composerId>:<bubbleId>` in the `cursorDiskKV` table.

The script merges both sources, sorts by modification time, and feeds the result into `fzf`. The preview panel extracts fenced code blocks and pipes each through `bat` for per-language syntax highlighting.

---

## Configuration

| Variable | Default | Description |
|----------|---------|-------------|
| `CLAUDE_PROJECTS_DIR` | `~/.claude/projects` | Override Claude session directory |
| `CURSOR_GLOBALSTATE_DB` | OS default (see above) | Override Cursor DB path |

---

## Output format

On `Enter`, `ass` prints:

- **Claude** — absolute path: `/home/you/.claude/projects/.../uuid.jsonl`
- **Cursor** — `cursor:<composerId>:<workspacePath>`

The Cursor identifier encodes the workspace path after the second `:`. On macOS and Linux, paths cannot contain `:`, so splitting on `:` with a limit of 3 is safe.

---

## Known limitations

- **Cursor resume** opens the project folder (`cursor --reuse-window <path>`); there is no CLI to jump to a specific chat session.
- **Zed** — the `threads.db` schema exists but sessions are stored as blobs in an undocumented format. Support can be added once the format is confirmed.
- **Windows** — paths and the Cursor DB location would need adaptation; WSL is untested.
