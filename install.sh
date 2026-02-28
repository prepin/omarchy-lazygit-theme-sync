#!/bin/bash
# Install omarchy-delta-theme-sync

set -e

echo "Installing omarchy-delta-theme-sync..."

# Copy script
cp scripts/omarchy-delta-theme-apply ~/.local/bin/
chmod +x ~/.local/bin/omarchy-delta-theme-apply

# Create delta themes directory
mkdir -p ~/.config/delta/themes

# Add hook to theme-set
HOOK_FILE="$HOME/.config/omarchy/hooks/theme-set"
if [[ -f "$HOOK_FILE" ]]; then
  if ! grep -q "omarchy-delta-theme-sync" "$HOOK_FILE" 2>/dev/null; then
    cat >> "$HOOK_FILE" << 'HOOK'

# >>> omarchy-delta-theme-sync hook >>>
# Apply delta (git diff) theme on Omarchy theme change
if [[ -f ~/.local/bin/omarchy-delta-theme-apply ]]; then
  ~/.local/bin/omarchy-delta-theme-apply "$1"
fi
# <<< omarchy-delta-theme-sync hook <<<
HOOK
    echo "✓ Hook added to theme-set"
  else
    echo "✓ Hook already present"
  fi
else
  echo "⚠ Warning: theme-set hook file not found"
fi

# Apply current theme
if [[ -f ~/.local/bin/omarchy-delta-theme-apply ]]; then
  CURRENT_THEME=$(cat ~/.config/omarchy/current/theme.name 2>/dev/null || echo "catppuccin")
  ~/.local/bin/omarchy-delta-theme-apply "$CURRENT_THEME"
fi

echo ""
echo "✓ Installation complete!"
echo ""
echo "Delta will now automatically sync with Omarchy theme changes."
