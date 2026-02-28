#!/bin/bash
# Generate all lazygit themes from Omarchy themes

OMARCHY_THEMES="$HOME/.local/share/omarchy/themes"
OUTPUT_DIR="$HOME/Work/tries/2026-02-28-omarch-lazygit-theme-sync/themes"
TEMPLATE="$HOME/Work/tries/2026-02-28-omarch-lazygit-theme-sync/templates/lazygit-theme.yml.tpl"

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

  # Parse colors.toml and extract values
  declare -A colors
  while IFS='=' read -r key value; do
    key="${key//[\"\' ]/}"
    [[ $key && $key != \#* ]] || continue
    value="${value#*[\"\']}"
    value="${value%%[\"\']*}"
    colors["$key"]="$value"
  done <"$colors_file"

  # Create sed script for template substitution
  sed_script=$(mktemp)
  for key in "${!colors[@]}"; do
    printf 's|{{ %s }}|%s|g\n' "$key" "${colors[$key]}" >> "$sed_script"
  done

  # Apply template
  sed -f "$sed_script" "$TEMPLATE" > "$output_file"
  rm "$sed_script"
}

# Generate themes for all Omarchy themes
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
