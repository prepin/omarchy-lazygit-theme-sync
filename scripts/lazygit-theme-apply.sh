#!/bin/bash
# Apply lazygit theme based on Omarchy theme

set -euo pipefail

THEME_NAME=$1
BUNDLED_THEMES="$HOME/.config/omarchy/lazygit-themes"
CURRENT_COLORS="$HOME/.config/omarchy/current/theme/colors.toml"
CURRENT_ALACRITTY="$HOME/.config/omarchy/current/theme/alacritty.toml"
THEME_OUTPUT="$HOME/.config/lazygit/theme.yml"
LIGHT_MODE_FILE="$HOME/.config/omarchy/current/theme/light.mode"

log_info() {
  echo "[INFO] $*"
}

log_success() {
  echo "[SUCCESS] $*"
}

log_warn() {
  echo "[WARN] $*"
}

log_error() {
  echo "[ERROR] $*" >&2
}

# Skip if toggled off
SKIP_FILE="$HOME/.config/omarchy/toggles/skip-lazygit-theme"
if [[ -f "$SKIP_FILE" ]]; then
  exit 0
fi

# Ensure lazygit config directory exists
mkdir -p "$(dirname "$THEME_OUTPUT")"

# Determine theme source
THEME_SOURCE=""
if [[ -f "$LIGHT_MODE_FILE" ]]; then
  # Try light variant first for light themes
  LIGHT_THEME="${THEME_NAME}-light"
  
  # Check patterns: theme-name-light.yml, theme-name-latte.yml, theme-name.yml
  if [[ -f "$BUNDLED_THEMES/${LIGHT_THEME}.yml" ]]; then
    THEME_SOURCE="$BUNDLED_THEMES/${LIGHT_THEME}.yml"
    log_info "Using bundled light theme: $LIGHT_THEME"
  elif [[ -f "$BUNDLED_THEMES/${THEME_NAME}-latte.yml" ]]; then
    THEME_SOURCE="$BUNDLED_THEMES/${THEME_NAME}-latte.yml"
    log_info "Using bundled latte theme: ${THEME_NAME}-latte"
  elif [[ -f "$BUNDLED_THEMES/$THEME_NAME.yml" ]]; then
    THEME_SOURCE="$BUNDLED_THEMES/$THEME_NAME.yml"
    log_info "Using bundled theme: $THEME_NAME"
  fi
else
  # Try standard theme
  if [[ -f "$BUNDLED_THEMES/$THEME_NAME.yml" ]]; then
    THEME_SOURCE="$BUNDLED_THEMES/$THEME_NAME.yml"
    log_info "Using bundled theme: $THEME_NAME"
  fi
fi

if [[ -n "$THEME_SOURCE" ]]; then
  # Use bundled theme
  cp "$THEME_SOURCE" "$THEME_OUTPUT"
else
  # Generate from theme color config with fallback
  if [[ -f "$CURRENT_COLORS" ]]; then
    ~/.local/bin/omarchy-lazygit-theme-generate "$CURRENT_COLORS" > "$THEME_OUTPUT"
    log_info "Generated lazygit theme from colors.toml"
  elif [[ -f "$CURRENT_ALACRITTY" ]]; then
    ~/.local/bin/omarchy-lazygit-theme-generate "$CURRENT_ALACRITTY" > "$THEME_OUTPUT"
    log_info "colors.toml missing; generated lazygit theme from alacritty.toml"
  else
    log_error "No bundled theme found and no colors.toml or alacritty.toml available"
    exit 1
  fi
fi

log_success "Applied lazygit theme: $THEME_NAME"
