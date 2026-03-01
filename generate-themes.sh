#!/bin/bash
# Generate all lazygit themes from Omarchy themes

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OMARCHY_THEMES="$HOME/.local/share/omarchy/themes"
OUTPUT_DIR="$SCRIPT_DIR/themes"
GENERATOR="$SCRIPT_DIR/scripts/lazygit-theme-generate.sh"

mkdir -p "$OUTPUT_DIR"

generate_theme() {
  local theme_name=$1
  local colors_file="$OMARCHY_THEMES/$theme_name/colors.toml"
  local output_file="$OUTPUT_DIR/${theme_name}.yml"

  if [[ ! -f "$colors_file" ]]; then
    echo "Warning: No colors.toml found for theme: $theme_name"
    return
  fi

  echo "Generating theme for: $theme_name"
  "$GENERATOR" "$colors_file" > "$output_file"
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

echo "Theme generation complete!"
