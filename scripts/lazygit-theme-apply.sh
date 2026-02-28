#!/bin/bash
# Apply lazygit theme based on Omarchy theme

THEME_NAME=$1
BUNDLED_THEMES="$HOME/.config/omarchy/lazygit-themes"
CURRENT_COLORS="$HOME/.config/omarchy/current/theme/colors.toml"
THEME_OUTPUT="$HOME/.config/lazygit/theme.yml"
LIGHT_MODE_FILE="$HOME/.config/omarchy/current/theme/light.mode"

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
  if [[ -f "$BUNDLED_THEMES/$LIGHT_THEME.yml" ]]; then
    THEME_SOURCE="$BUNDLED_THEMES/$LIGHT_THEME.yml"
    echo "Using bundled light theme: $LIGHT_THEME"
  elif [[ -f "$BUNDLED_THEMES/$THEME_NAME.yml" ]]; then
    THEME_SOURCE="$BUNDLED_THEMES/$THEME_NAME.yml"
    echo "Using bundled theme: $THEME_NAME"
  fi
else
  # Try standard theme
  if [[ -f "$BUNDLED_THEMES/$THEME_NAME.yml" ]]; then
    THEME_SOURCE="$BUNDLED_THEMES/$THEME_NAME.yml"
    echo "Using bundled theme: $THEME_NAME"
  fi
fi

if [[ -n "$THEME_SOURCE" ]]; then
  # Use bundled theme
  cp "$THEME_SOURCE" "$THEME_OUTPUT"
else
  # Generate from colors.toml
  if [[ -f "$CURRENT_COLORS" ]]; then
    ~/.local/bin/omarchy-lazygit-theme-generate "$CURRENT_COLORS" > "$THEME_OUTPUT"
    echo "Generated lazygit theme from colors.toml"
  else
    echo "Warning: No bundled theme found and colors.toml missing"
    exit 1
  fi
fi

echo "Applied lazygit theme: $THEME_NAME"
