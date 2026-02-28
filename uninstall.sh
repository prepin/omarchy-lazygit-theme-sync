#!/bin/bash
# Uninstall omarchy-delta-theme-sync

set -e

echo "Uninstalling omarchy-delta-theme-sync..."

# Remove script
if [[ -f ~/.local/bin/omarchy-delta-theme-apply ]]; then
  rm ~/.local/bin/omarchy-delta-theme-apply
  echo "✓ Removed script"
fi

# Remove delta theme file
if [[ -f ~/.config/delta/themes/omarchy.gitconfig ]]; then
  rm ~/.config/delta/themes/omarchy.gitconfig
  echo "✓ Removed delta theme file"
fi

# Remove include from gitconfig
if [[ -f ~/.gitconfig ]]; then
  if grep -q "omarchy-delta-theme-sync" ~/.gitconfig 2>/dev/null; then
    # Use sed to remove the include section
    sed -i '/# >>> omarchy-delta-theme-sync >>>/,/# <<< omarchy-delta-theme-sync <<</d' ~/.gitconfig
    echo "✓ Removed include from gitconfig"
  fi
fi

# Remove hook from theme-set
HOOK_FILE="$HOME/.config/omarchy/hooks/theme-set"
if [[ -f "$HOOK_FILE" ]]; then
  if grep -q "omarchy-delta-theme-sync" "$HOOK_FILE" 2>/dev/null; then
    sed -i '/# >>> omarchy-delta-theme-sync hook >>>/,/# <<< omarchy-delta-theme-sync hook <<</d' "$HOOK_FILE"
    echo "✓ Removed hook from theme-set"
  fi
fi

echo ""
echo "✓ Uninstallation complete!"
