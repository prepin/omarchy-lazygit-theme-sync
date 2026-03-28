#!/bin/bash
# Generate all lazygit themes from Omarchy themes

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OMARCHY_THEMES="$HOME/.local/share/omarchy/themes"
OUTPUT_DIR="$SCRIPT_DIR/themes"
GENERATOR="$SCRIPT_DIR/scripts/lazygit-theme-generate.sh"

mkdir -p "$OUTPUT_DIR"

log_info() {
  echo "[INFO] $*"
}

log_success() {
  echo "[SUCCESS] $*"
}

log_warn() {
  echo "[WARN] $*"
}

generate_theme() {
  local theme_name=$1
  local colors_file="$OMARCHY_THEMES/$theme_name/colors.toml"
  local alacritty_file="$OMARCHY_THEMES/$theme_name/alacritty.toml"
  local output_file="$OUTPUT_DIR/${theme_name}.yml"
  local source_file=""

  if [[ -f "$colors_file" ]]; then
    source_file="$colors_file"
  elif [[ -f "$alacritty_file" ]]; then
    source_file="$alacritty_file"
    log_info "colors.toml missing for $theme_name; using alacritty.toml"
  else
    log_warn "No colors.toml or alacritty.toml found for theme: $theme_name"
    return
  fi

  log_info "Generating theme for: $theme_name"
  "$GENERATOR" "$source_file" > "$output_file"
}

themes=(
  "catppuccin"
  "catppuccin-latte"
  "ethereal"
  "everforest"
  "flexoki-light"
  "gruvbox"
  "hackerman"
  "kanagawa"
  "matte-black"
  "miasma"
  "nord"
  "osaka-jade"
  "ristretto"
  "rose-pine"
  "tokyo-night"
  "vantablack"
  "white"
)

for theme in "${themes[@]}"; do
  generate_theme "$theme"
done

log_success "Theme generation complete"
