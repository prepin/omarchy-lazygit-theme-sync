#!/bin/bash
# Generate lazygit theme using derivative colors

set -euo pipefail

COLORS_FILE=$1

log_error() {
  echo "[ERROR] $*" >&2
}

if [[ ! -f "$COLORS_FILE" ]]; then
  log_error "Colors file not found: $COLORS_FILE"
  exit 1
fi

validate_colors() {
  local required=(background foreground color1 color3 accent)
  local key

  for key in "${required[@]}"; do
    if [[ -z "${colors[$key]:-}" ]]; then
      log_error "Missing required color '$key'"
      exit 1
    fi
  done
}

parse_colors_toml() {
  while IFS='=' read -r key value; do
    key="${key//[\"\' ]/}"
    [[ $key && $key != \#* ]] || continue
    value="${value#*[\"\']}"
    value="${value%%[\"\']*}"
    colors["$key"]="$value"
  done <"$COLORS_FILE"

  validate_colors
}

parse_alacritty_toml() {
  local section=""

  while IFS= read -r line; do
    if [[ $line =~ ^[[:space:]]*\[(.+)\][[:space:]]*$ ]]; then
      section="${BASH_REMATCH[1]}"
      continue
    fi

    if [[ $line =~ ^[[:space:]]*([a-zA-Z_]+)[[:space:]]*=[[:space:]]*\"(#[0-9A-Fa-f]{6})\"[[:space:]]*$ ]]; then
      local key="${BASH_REMATCH[1]}"
      local value="${BASH_REMATCH[2]}"
      case "$section.$key" in
        colors.primary.background) colors[background]="$value" ;;
        colors.primary.foreground) colors[foreground]="$value" ;;
        colors.normal.red) colors[color1]="$value" ;;
        colors.normal.green) colors[color2]="$value" ;;
        colors.normal.yellow) colors[color3]="$value" ;;
        colors.normal.blue)
          colors[color4]="$value"
          colors[accent]="$value"
          ;;
        colors.normal.magenta) colors[color5]="$value" ;;
      esac
    fi
  done <"$COLORS_FILE"

  if [[ -z "${colors[accent]:-}" && -n "${colors[color4]:-}" ]]; then
    colors[accent]="${colors[color4]}"
  fi

  validate_colors
}

declare -A colors
if [[ "$COLORS_FILE" == *.toml ]]; then
  if grep -q '^\[colors\.' "$COLORS_FILE"; then
    parse_alacritty_toml
  else
    parse_colors_toml
  fi
else
  log_error "Unsupported color file format: $COLORS_FILE"
  exit 1
fi

# Color manipulation functions
hex_to_rgb() {
  local hex="$1"
  hex="${hex#\#}"
  local r=$((16#${hex:0:2}))
  local g=$((16#${hex:2:2}))
  local b=$((16#${hex:4:2}))
  echo "$r $g $b"
}

rgb_to_hex() {
  local r="$1" g="$2" b="$3"
  printf "#%02x%02x%02x" "$r" "$g" "$b"
}

lighten_color() {
  local hex="$1"
  local factor="${2:-10}"
  
  read -r r g b <<< "$(hex_to_rgb "$hex")"
  
  r=$(( r + (255 - r) * factor / 100 ))
  g=$(( g + (255 - g) * factor / 100 ))
  b=$(( b + (255 - b) * factor / 100 ))
  
  r=$((r > 255 ? 255 : r))
  g=$((g > 255 ? 255 : g))
  b=$((b > 255 ? 255 : b))
  
  rgb_to_hex "$r" "$g" "$b"
}

darken_color() {
  local hex="$1"
  local factor="${2:-10}"
  
  read -r r g b <<< "$(hex_to_rgb "$hex")"
  
  local multiplier=$((100 - factor))
  r=$((r * multiplier / 100))
  g=$((g * multiplier / 100))
  b=$((b * multiplier / 100))
  
  r=$((r < 0 ? 0 : r))
  g=$((g < 0 ? 0 : g))
  b=$((b < 0 ? 0 : b))
  
  rgb_to_hex "$r" "$g" "$b"
}

# Determine if light or dark theme
bg="${colors[background]}"
bg_r=$((16#${bg:1:2}))
bg_g=$((16#${bg:3:2}))
bg_b=$((16#${bg:5:2}))
bg_brightness=$((bg_r + bg_g + bg_b))

# Calculate derivative colors based on theme type
# Max brightness = 765 (255*3). Light themes have brightness > 382, dark themes < 382
if [[ $bg_brightness -gt 382 ]]; then
  # Light theme - darken background for selection (good contrast)
  selected_bg=$(darken_color "$bg" 4)
else
  # Dark theme - lighten background for selection (good contrast)
  selected_bg=$(lighten_color "$bg" 10)
fi

# Output theme
cat << THEME
gui:
  theme:
    activeBorderColor:
      - '${colors[accent]}'
      - bold
    inactiveBorderColor:
      - '${colors[foreground]}'
    optionsTextColor:
      - '${colors[accent]}'
    selectedLineBgColor:
      - '$selected_bg'
    cherryPickedCommitBgColor:
      - '$selected_bg'
    cherryPickedCommitFgColor:
      - '${colors[foreground]}'
    unstagedChangesColor:
      - '${colors[color1]}'
    defaultFgColor:
      - '${colors[foreground]}'
    searchingActiveBorderColor:
      - '${colors[color3]}'
      - bold
    authorColors:
      '*': '${colors[accent]}'
THEME
