#!/bin/bash
# Generate lazygit theme from Omarchy colors.toml

COLORS_FILE=$1
TEMPLATE="$HOME/.local/share/omarchy-lazygit-theme-sync/lazygit-theme.yml.tpl"

# Check if colors file exists
if [[ ! -f "$COLORS_FILE" ]]; then
  echo "Error: Colors file not found: $COLORS_FILE"
  exit 1
fi

# Check if template exists
if [[ ! -f "$TEMPLATE" ]]; then
  echo "Error: Template file not found: $TEMPLATE"
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

# Create sed script for template substitution
sed_script=$(mktemp)
for key in "${!colors[@]}"; do
  printf 's|{{ %s }}|%s|g\n' "$key" "${colors[$key]}" >> "$sed_script"
  printf 's|{{ %s_strip }}|%s|g\n' "$key" "${colors[$key]#\#}" >> "$sed_script"
done

# Apply template and clean up
sed -f "$sed_script" "$TEMPLATE"
rm "$sed_script"
