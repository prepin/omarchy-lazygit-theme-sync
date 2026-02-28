#!/bin/bash
# Generate lazygit theme from Omarchy colors.toml using theme presets

COLORS_FILE=$1
PRESETS_SCRIPT="$(dirname "$0")/../theme-mappings/presets.sh"

# Check if colors file exists
if [[ ! -f "$COLORS_FILE" ]]; then
  echo "Error: Colors file not found: $COLORS_FILE"
  exit 1
fi

# Parse colors.toml and extract values
declare -A colors
while IFS='=' read -r key value; do
  key="${key//[\"\' ]/}"
  [[ $key && $key != \#* ]] || continue
  value="${value#*[\"\']}"
  value="${value%%[\"\']*}"
  colors["$key"]="$value"
done <"$COLORS_FILE"

# Determine theme name from colors file path
theme_name=$(basename "$(dirname "$COLORS_FILE")")

# Get preset mapping for this theme
preset_output=$("$PRESETS_SCRIPT" "$theme_name")

# Parse preset into associative array
declare -A mapping
while IFS=':' read -r key value; do
  key="${key// /}"
  [[ $key ]] || continue
  value="${value// /}"
  mapping["$key"]="$value"
done <<< "$preset_output"

# Output lazygit theme directly (no template)
cat << THEME
gui:
  theme:
    activeBorderColor:
      - '${colors[${mapping[activeBorderColor]}]}'
      - bold
    inactiveBorderColor:
      - '${colors[${mapping[inactiveBorderColor]}]}'
    optionsTextColor:
      - '${colors[${mapping[optionsTextColor]}]}'
    selectedLineBgColor:
      - '${colors[${mapping[selectedLineBgColor]}]}'
    cherryPickedCommitBgColor:
      - '${colors[${mapping[cherryPickedCommitBgColor]}]}'
    cherryPickedCommitFgColor:
      - '${colors[${mapping[cherryPickedCommitFgColor]}]}'
    unstagedChangesColor:
      - '${colors[${mapping[unstagedChangesColor]}]}'
    defaultFgColor:
      - '${colors[${mapping[defaultFgColor]}]}'
    searchingActiveBorderColor:
      - '${colors[${mapping[searchingActiveBorderColor]}]}'
      - bold
    authorColors:
      '*': '${colors[${mapping[authorColors]}]}'
THEME
