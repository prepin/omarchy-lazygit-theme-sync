#!/bin/bash
# Install omarchy-theme-sync for lazygit and delta

set -e

echo "Installing omarchy-theme-sync..."

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Copy lazygit scripts
cp "$SCRIPT_DIR/scripts/lazygit-theme-apply.sh" ~/.local/bin/omarchy-lazygit-theme-apply
chmod +x ~/.local/bin/omarchy-lazygit-theme-apply

cp "$SCRIPT_DIR/scripts/lazygit-theme-generate.sh" ~/.local/bin/omarchy-lazygit-theme-generate
chmod +x ~/.local/bin/omarchy-lazygit-theme-generate

# Copy delta script
cp "$SCRIPT_DIR/scripts/omarchy-delta-theme-apply" ~/.local/bin/
chmod +x ~/.local/bin/omarchy-delta-theme-apply

# Copy bundled themes
mkdir -p ~/.config/omarchy/lazygit-themes
cp "$SCRIPT_DIR/themes/"*.yml ~/.config/omarchy/lazygit-themes/

# Create delta themes directory
mkdir -p ~/.config/delta/themes

# Add hook to theme-set
HOOK_FILE="$HOME/.config/omarchy/hooks/theme-set"
if [[ -f "$HOOK_FILE" ]]; then
  if ! grep -q "omarchy-lazygit-theme-apply" "$HOOK_FILE" 2>/dev/null; then
    cat >> "$HOOK_FILE" << 'HOOK'

# >>> omarchy-theme-sync hook >>>
# Apply lazygit and delta themes on Omarchy theme change
if [[ -f ~/.local/bin/omarchy-lazygit-theme-apply ]]; then
  ~/.local/bin/omarchy-lazygit-theme-apply "$1"
fi
if [[ -f ~/.local/bin/omarchy-delta-theme-apply ]]; then
  ~/.local/bin/omarchy-delta-theme-apply "$1"
fi
# <<< omarchy-theme-sync hook <<<
HOOK
    echo "✓ Hook added to theme-set"
  else
    echo "✓ Hook already present"
  fi
else
  echo "⚠ Warning: theme-set hook file not found"
fi

# Apply current theme
CURRENT_THEME=$(cat ~/.config/omarchy/current/theme.name 2>/dev/null || echo "catppuccin")

if [[ -f ~/.local/bin/omarchy-lazygit-theme-apply ]]; then
  ~/.local/bin/omarchy-lazygit-theme-apply "$CURRENT_THEME"
fi

if [[ -f ~/.local/bin/omarchy-delta-theme-apply ]]; then
  ~/.local/bin/omarchy-delta-theme-apply "$CURRENT_THEME"
fi

echo ""
echo "✓ Installation complete!"
echo ""
echo "Lazygit and Delta will now automatically sync with Omarchy theme changes."
