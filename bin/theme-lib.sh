#!/usr/bin/env bash
#
# theme-lib.sh — palette data and config generators for bin/theme.
#
set -euo pipefail

DOTFILES_ROOT="${DOTFILES_ROOT:-$HOME/.dotfiles}"
THEME_DIR="$DOTFILES_ROOT/theme"
GENERATED_DIR="$THEME_DIR/generated"
ACTIVE_ENV="$THEME_DIR/active.env"
TMUX_STATUS_STYLE_DEFAULT=extensive

# Catppuccin only — id|label|description
TMUX_STATUS_STYLE_CATALOG=(
	"extensive|Extensive|Custom tabs — #I:#T, colored colon and pipe separators"
	"simple|Simple|Catppuccin basic tabs — plugin default layout and colors"
)

theme_normalize_status_style() {
	case "$1" in
		rose-pine) printf 'simple' ;; # legacy id (pre-rename)
		*) printf '%s' "$1" ;;
	esac
}

# family|variant|mode|label|swatch1|swatch2|swatch3|swatch4|swatch5
THEME_CATALOG=(
	"catppuccin|macchiato|dark|Catppuccin Macchiato|#24273a|#cad3f5|#b7bdf8|#a5adcb|#c6a0f6"
	"catppuccin|mocha|dark|Catppuccin Mocha|#1e1e2e|#cdd6f4|#b4befe|#a6adc8|#cba6f7"
	"catppuccin|frappe|dark|Catppuccin Frappé|#303446|#c6d0f5|#babbf1|#b5bfe2|#ca9ee6"
	"catppuccin|latte|light|Catppuccin Latte|#eff1f5|#4c4f69|#7287fd|#6c6f85|#8839ef"
	"rose-pine|moon|dark|Rosé Pine Moon|#232136|#e0def4|#f6c177|#908caa|#c4a7e7"
	"rose-pine|main|dark|Rosé Pine|#191724|#e0def4|#f6c177|#908caa|#c4a7e7"
	"rose-pine|dawn|light|Rosé Pine Dawn|#faf4ed|#575279|#ea9d34|#797593|#907aa9"
	"legacy|onedark|dark|Legacy (One Dark)|#282c34|#abb2bf|#61afef|#5c6370|#c678dd"
)

theme_catalog_entry() {
	local want_family=$1 want_variant=$2 entry
	for entry in "${THEME_CATALOG[@]}"; do
		IFS='|' read -r family variant mode label _ <<< "$entry"
		if [[ $family == "$want_family" && $variant == "$want_variant" ]]; then
			printf '%s' "$entry"
			return 0
		fi
	done
	return 1
}

theme_palette() {
	local family=$1 variant=$2
	case "$family:$variant" in
		catppuccin:macchiato)
			P_BASE="#24273a" P_SURFACE="#1e2030" P_MUTED="#a5adcb" P_SUBTLE="#b8c0e0"
			P_TEXT="#cad3f5" P_ACCENT="#b7bdf8" P_ACCENT2="#c6a0f6" P_BORDER="#494d64"
			P_CRUST="#181926" P_GOLD="#f5a97f"
			;;
		catppuccin:mocha)
			P_BASE="#1e1e2e" P_SURFACE="#181825" P_MUTED="#a6adc8" P_SUBTLE="#bac2de"
			P_TEXT="#cdd6f4" P_ACCENT="#b4befe" P_ACCENT2="#cba6f7" P_BORDER="#45475a"
			P_CRUST="#11111b" P_GOLD="#fab387"
			;;
		catppuccin:frappe)
			P_BASE="#303446" P_SURFACE="#292c3c" P_MUTED="#b5bfe2" P_SUBTLE="#c6d0f5"
			P_TEXT="#c6d0f5" P_ACCENT="#babbf1" P_ACCENT2="#ca9ee6" P_BORDER="#51576d"
			P_CRUST="#232634" P_GOLD="#ef9f76"
			;;
		catppuccin:latte)
			P_BASE="#eff1f5" P_SURFACE="#e6e9ef" P_MUTED="#6c6f85" P_SUBTLE="#7c7f93"
			P_TEXT="#4c4f69" P_ACCENT="#7287fd" P_ACCENT2="#8839ef" P_BORDER="#bcc0cc"
			P_CRUST="#dce0e8" P_GOLD="#fe640b"
			;;
		rose-pine:moon)
			P_BASE="#232136" P_SURFACE="#2a273f" P_MUTED="#6e6a86" P_SUBTLE="#908caa"
			P_TEXT="#e0def4" P_ACCENT="#f6c177" P_ACCENT2="#c4a7e7" P_BORDER="#56526e"
			P_CRUST="#232136" P_GOLD="#f6c177"
			;;
		rose-pine:main)
			P_BASE="#191724" P_SURFACE="#1f1d2e" P_MUTED="#6e6a86" P_SUBTLE="#908caa"
			P_TEXT="#e0def4" P_ACCENT="#f6c177" P_ACCENT2="#c4a7e7" P_BORDER="#524f67"
			P_CRUST="#191724" P_GOLD="#f6c177"
			;;
		rose-pine:dawn)
			P_BASE="#faf4ed" P_SURFACE="#fffaf3" P_MUTED="#9893a5" P_SUBTLE="#797593"
			P_TEXT="#575279" P_ACCENT="#ea9d34" P_ACCENT2="#907aa9" P_BORDER="#cecacd"
			P_CRUST="#faf4ed" P_GOLD="#ea9d34"
			;;
		legacy:onedark)
			P_BASE="#282c34" P_SURFACE="#21252b" P_MUTED="#5c6370" P_SUBTLE="#7f848e"
			P_TEXT="#abb2bf" P_ACCENT="#61afef" P_ACCENT2="#c678dd" P_BORDER="#3e4451"
			P_CRUST="#21252b" P_GOLD="#e5c07b"
			;;
		*)
			echo "unknown theme: $family/$variant" >&2
			return 1
			;;
	esac
}

theme_write_active_env() {
	local family=$1 variant=$2 mode=$3
	local status_style=${4:-}

	if [[ -z $status_style ]]; then
		status_style=$TMUX_STATUS_STYLE_DEFAULT
		if [[ -f $ACTIVE_ENV ]]; then
			# shellcheck disable=SC1090
			source "$ACTIVE_ENV"
			status_style=${TMUX_STATUS_STYLE:-$status_style}
			status_style=$(theme_normalize_status_style "$status_style")
		fi
	else
		status_style=$(theme_normalize_status_style "$status_style")
	fi
	mkdir -p "$THEME_DIR"
	cat >"$ACTIVE_ENV" <<EOF
# Active UI theme — managed by bin/theme (do not edit by hand).
THEME_FAMILY=$family
THEME_VARIANT=$variant
THEME_MODE=$mode
TMUX_STATUS_STYLE=$status_style
EOF
	TMUX_STATUS_STYLE=$status_style
	THEME_FAMILY=$family
	THEME_VARIANT=$variant
	THEME_MODE=$mode
}

theme_write_ghostty() {
	local family=$1 variant=$2
	mkdir -p "$GENERATED_DIR"
	case "$family" in
		catppuccin)
			printf 'theme = catppuccin-%s.conf\n' "$variant" >"$GENERATED_DIR/ghostty.conf"
			;;
		rose-pine)
			local theme_name=$variant
			[[ $variant == main ]] && theme_name=rose-pine || theme_name="rose-pine-$variant"
			printf 'theme = %s\n' "$theme_name" >"$GENERATED_DIR/ghostty.conf"
			;;
		legacy)
			cat >"$GENERATED_DIR/ghostty.conf" <<'EOF'
# Legacy — Ghostty built-in default (no theme file)
EOF
			;;
	esac
}

theme_write_tmux_catppuccin_extensive() {
	local variant=$1
	cat >"$GENERATED_DIR/tmux.conf" <<EOF
# Generated by bin/theme — catppuccin/$variant + extensive status
set -g @catppuccin_flavor '$variant'
set -g @catppuccin_window_current_text " #T#{?window_zoomed_flag, [Z],}"
set -g @catppuccin_window_status_style "none"
run '$HOME/.tmux/plugins/catppuccin-tmux/catppuccin.tmux'

set -gF status-style "fg=#{@thm_subtext_0},bg=#{@thm_mantle}"
set -gF window-status-style "fg=#{@thm_subtext_0},bg=#{@thm_mantle}"
set -gF window-status-current-style "fg=#{@thm_mauve},bg=#{@thm_mantle},bold"
set -gF window-status-activity-style "fg=#{@thm_lavender},bg=#{@thm_mantle}"
set -gF window-status-bell-style "fg=#{@thm_yellow},bg=#{@thm_mantle}"
set -gF window-status-format ' ##I#[fg=#{@thm_overlay_0}]:##T '
set -gF window-status-current-format ' ##I#[fg=#{@thm_overlay_0}]:#{@catppuccin_window_current_text} '
set -gF window-status-separator '#[fg=#{@thm_overlay_1}] | '

set -g status-left-length 100
set -g status-right-length 100
set -g status-left ""
set -g status-right '#[fg=#{@thm_crust},bg=#{@thm_teal}] session: #S '
EOF
}

theme_write_tmux_catppuccin_simple_status() {
	local variant=$1
	cat >"$GENERATED_DIR/tmux.conf" <<EOF
# Generated by bin/theme — catppuccin/$variant + simple status
set -g @catppuccin_flavor '$variant'
set -g @catppuccin_window_status_style "basic"
set -g @catppuccin_window_flags "none"
set -g @catppuccin_window_text "#T"
set -g @catppuccin_window_current_text " #T#{?window_zoomed_flag, [Z],}"
run '$HOME/.tmux/plugins/catppuccin-tmux/catppuccin.tmux'

set -g status-left-length 100
set -g status-right-length 100
set -g status-left ""
set -g status-right '#[fg=#{@thm_crust},bg=#{@thm_teal}] session: #S '
EOF
}

theme_write_tmux() {
	local family=$1 variant=$2
	theme_palette "$family" "$variant"
	mkdir -p "$GENERATED_DIR"

	if [[ $family == catppuccin ]]; then
		local style
		style=$(theme_normalize_status_style "${TMUX_STATUS_STYLE:-$TMUX_STATUS_STYLE_DEFAULT}")
		if [[ $style == simple ]]; then
			theme_write_tmux_catppuccin_simple_status "$variant"
		else
			theme_write_tmux_catppuccin_extensive "$variant"
		fi

		cat >"$GENERATED_DIR/tmux-panes.conf" <<'EOF'
# Generated by bin/theme — pane labels (catppuccin colors via @thm_*)
set-window-option -g pane-border-status bottom
set-window-option -g pane-border-lines heavy
set-window-option -g pane-border-format '#{?pane_active,#[fg=#{@thm_lavender}]#[bold],#[fg=#{@thm_subtext_1}]}#{pane_title}'

setw -g window-style "default"
setw -g window-active-style "default"

set -g message-command-style "fg=#{@thm_crust},bg=#{@thm_peach},fill=#{@thm_peach},width=100%"
set -g message-style "fg=#{@thm_subtext_1},bg=#{@thm_bg},fill=#{@thm_bg},width=100%"
EOF
	elif [[ $family == legacy ]]; then
		cat >"$GENERATED_DIR/tmux.conf" <<EOF
# Generated by bin/theme — legacy/onedark
set -g @rose_pine_variant 'moon'
set -g @rose_pine_bar_bg_disable 'on'
set -g @rose_pine_bar_bg_disabled_color_option '0'
set -g @rose_pine_disable_active_window_menu 'on'
set -g @rose_pine_show_current_program 'on'
set -g @rose_pine_field_separator ' | '
run '$HOME/.tmux/plugins/rose-pine-tmux/rose-pine.tmux'
setw -ga window-status-current-format "#{?window_zoomed_flag, [Z],}"

set -g message-command-style "fg=#232136,bg=#f6c177,fill=#f6c177,width=100%"
set -g message-style "fg=#6e6a86,bg=#232136,fill=#232136,width=100%"
EOF

		cat >"$GENERATED_DIR/tmux-panes.conf" <<'EOF'
# Generated by bin/theme — legacy pane labels
set-window-option -g pane-border-status bottom
set-window-option -g pane-border-lines heavy
set-window-option -g pane-border-format '#{?pane_active,#[bold],}#{pane_title}#[default]'

setw -g window-active-style fg=colour15,bg=colour235
EOF
	else
		cat >"$GENERATED_DIR/tmux.conf" <<EOF
# Generated by bin/theme — rose-pine/$variant
set -g @rose_pine_variant '$variant'
set -g @rose_pine_bar_bg_disable 'on'
set -g @rose_pine_bar_bg_disabled_color_option '0'
set -g @rose_pine_disable_active_window_menu 'on'
set -g @rose_pine_show_current_program 'on'
set -g @rose_pine_field_separator ' | '
run '$HOME/.tmux/plugins/rose-pine-tmux/rose-pine.tmux'
setw -ga window-status-current-format "#{?window_zoomed_flag, [Z],}"
EOF

		cat >"$GENERATED_DIR/tmux-panes.conf" <<EOF
# Generated by bin/theme — pane labels for rose-pine/$variant
set-window-option -g pane-border-status bottom
set-window-option -g pane-border-lines heavy
set-window-option -g pane-border-format '#{?pane_active,#[fg=$P_ACCENT]#[bold],#[fg=$P_MUTED]}#{pane_title}'

set -g pane-border-style "fg=$P_BORDER"
set -g pane-active-border-style "fg=$P_ACCENT"

setw -g window-style "fg=$P_MUTED,bg=$P_SURFACE"
setw -g window-active-style "fg=$P_TEXT,bg=$P_BASE"

set -g message-command-style "fg=$P_CRUST,bg=$P_GOLD,fill=$P_GOLD,width=100%"
set -g message-style "fg=$P_MUTED,bg=$P_BASE,fill=$P_BASE,width=100%"
EOF
	fi
}

theme_write_nvim() {
	local family=$1 variant=$2 mode=$3
	theme_palette "$family" "$variant"
	mkdir -p "$GENERATED_DIR"
	local lualine_theme accent
	if [[ $family == catppuccin ]]; then
		lualine_theme="catppuccin"
		accent=$P_GOLD
	elif [[ $family == legacy ]]; then
		lualine_theme="legacy"
		accent="#ff9e64"
	else
		lualine_theme="rose-pine"
		accent=$P_GOLD
	fi
	cat >"$GENERATED_DIR/nvim.lua" <<EOF
-- Generated by bin/theme — $family/$variant
return {
  family = "$family",
  variant = "$variant",
  mode = "$mode",
  lualine = "$lualine_theme",
  accent = "$accent",
}
EOF
}

theme_apply() {
	local family=$1 variant=$2
	local entry mode label
	entry=$(theme_catalog_entry "$family" "$variant") || {
		echo "unknown theme: $family/$variant" >&2
		return 1
	}
	IFS='|' read -r _ _ mode label _ <<< "$entry"

	theme_write_active_env "$family" "$variant" "$mode"
	theme_regenerate_configs

	if [[ $family == catppuccin ]]; then
		echo "Applied $label ($family/$variant) · tmux status: $TMUX_STATUS_STYLE"
	else
		echo "Applied $label ($family/$variant)"
	fi
}

theme_regenerate_configs() {
	theme_write_ghostty "$THEME_FAMILY" "$THEME_VARIANT"
	theme_write_tmux "$THEME_FAMILY" "$THEME_VARIANT"
	theme_write_nvim "$THEME_FAMILY" "$THEME_VARIANT" "$THEME_MODE"
}

theme_status_style_valid() {
	local want=$1 entry id
	for entry in "${TMUX_STATUS_STYLE_CATALOG[@]}"; do
		IFS='|' read -r id _ _ <<< "$entry"
		[[ $id == "$want" ]] && return 0
	done
	echo "unknown tmux status style: $want" >&2
	return 1
}

theme_apply_status() {
	local style=$1
	theme_read_active
	if [[ $THEME_FAMILY != catppuccin ]]; then
		echo "tmux status styles are only available with catppuccin (current: $THEME_FAMILY)" >&2
		return 1
	fi
	theme_status_style_valid "$style" || return 1
	style=$(theme_normalize_status_style "$style")
	theme_write_active_env "$THEME_FAMILY" "$THEME_VARIANT" "$THEME_MODE" "$style"
	mkdir -p "$GENERATED_DIR"
	TMUX_STATUS_STYLE=$style
	theme_write_tmux "$THEME_FAMILY" "$THEME_VARIANT"
	local label
	label=$(theme_status_style_label "$style")
	echo "Applied tmux status style: $label ($style)"
}

theme_status_style_label() {
	local want=$1 entry id label
	for entry in "${TMUX_STATUS_STYLE_CATALOG[@]}"; do
		IFS='|' read -r id label _ <<< "$entry"
		[[ $id == "$want" ]] && {
			printf '%s' "$label"
			return 0
		}
	done
	printf '%s' "$want"
}

theme_list_status_lines() {
	local entry id label desc
	for entry in "${TMUX_STATUS_STYLE_CATALOG[@]}"; do
		IFS='|' read -r id label desc <<< "$entry"
		printf '%s|%s|%s\n' "$id" "$label" "$desc"
	done
}

theme_reload_ghostty() {
	if pgrep -x ghostty >/dev/null 2>&1; then
		kill -SIGUSR2 "$(pgrep -x ghostty)" 2>/dev/null || true
		echo "Reloaded Ghostty"
	fi
}

theme_reload_tmux() {
	if command -v tmux >/dev/null 2>&1 && tmux list-sessions >/dev/null 2>&1; then
		tmux source-file "$HOME/.tmux.conf"
		echo "Reloaded tmux"
	fi
}

theme_reload_nvim() {
	if ! command -v nvim >/dev/null 2>&1; then
		return 0
	fi
	if nvim --headless "+lua if pcall(require, 'kyriacos.theme') then require('kyriacos.theme').apply() end" +qa 2>/dev/null; then
		echo "Reloaded Neovim colorscheme"
	fi
}

theme_reload_all() {
	theme_reload_ghostty
	theme_reload_tmux
	theme_reload_nvim
}

theme_preview_ansi() {
	local _ family variant _mode _label s1 s2 s3 s4 s5
	IFS='|' read -r family variant _mode _label s1 s2 s3 s4 s5 <<< "$1"
	printf '\n  %s (%s/%s)\n' "$_label" "$family" "$variant"
	printf '  '
	printf '\033[48;2;%sm   \033[0m' "$(theme_hex_to_rgb "${s1//#/}")"
	printf '\033[48;2;%sm   \033[0m' "$(theme_hex_to_rgb "${s2//#/}")"
	printf '\033[48;2;%sm   \033[0m' "$(theme_hex_to_rgb "${s3//#/}")"
	printf '\033[48;2;%sm   \033[0m' "$(theme_hex_to_rgb "${s4//#/}")"
	printf '\033[48;2;%sm   \033[0m' "$(theme_hex_to_rgb "${s5//#/}")"
	printf '  base · text · accent · muted · highlight\n\n'
}

theme_hex_to_rgb() {
	local hex=$1
	printf '%d;%d;%d' "0x${hex:0:2}" "0x${hex:2:2}" "0x${hex:4:2}"
}

theme_list_lines() {
	local entry family variant mode label
	for entry in "${THEME_CATALOG[@]}"; do
		IFS='|' read -r family variant mode label _ <<< "$entry"
		printf '%s|%s|%s|%s\n' "$family" "$variant" "$mode" "$label"
	done
}

theme_read_active() {
	# shellcheck disable=SC1090
	source "$ACTIVE_ENV"
	TMUX_STATUS_STYLE=$(theme_normalize_status_style "${TMUX_STATUS_STYLE:-$TMUX_STATUS_STYLE_DEFAULT}")
}

theme_generate_all_from_active() {
	theme_read_active
	theme_write_active_env "$THEME_FAMILY" "$THEME_VARIANT" "$THEME_MODE"
	theme_regenerate_configs
}
