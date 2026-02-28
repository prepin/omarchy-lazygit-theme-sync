#!/bin/bash
# Uninstall omarchy-theme-sync

set -e

echo "Uninstalling omarchy-theme-sync..."

# Remove lazygit scripts
for script in omarchy-lazygit-theme-apply omarchy-lazygit-theme-generate; do
  if [[ -f ~/.local/bin/$script ]]; then
    rm ~/.local/bin/$script
    echo "✓ Removed $script"
  fi
done

# Remove delta script
if [[ -f ~/.local/bin/omarchy-delta-theme-apply ]]; then
  rm ~/.local/bin/omarchy-delta-theme-apply
  echo "✓ Removed omarchy-delta-theme-apply"
fi

# Remove lazygit themes
if [[ -d ~/.config/omarchy/lazygit-themes ]]; then
  rm -rf ~/.config/omarchy/lazygit-themes
  echo "✓ Removed lazygit themes"
fi

# Remove delta theme file
if [[ -f ~/.config/delta/themes/omarchy.gitconfig ]]; then
  rm ~/.config/delta/themes/omarchy.gitconfig
  echo "✓ Removed delta theme file"
fi

# Remove lazygit theme file
if [[ -f ~/.config/lazygit/theme.yml ]]; then
  rm ~/.config/lazygit/theme.yml
  echo "✓ Removed lazygit theme file"
fi

# Remove include from gitconfig
if [[ -f ~/.gitconfig ]]; then
  if grep -q "omarchy.gitconfig" ~/.gitconfig 2>/dev/null; then
    sed -i '/# >>> omarchy-delta-theme-sync >>>/,/# <<< omarchy-delta-theme-sync <<</d' ~/.gitconfig
    echo "✓ Removed include from gitconfig"
  fi
fi

# Remove hook from theme-set
HOOK_FILE="$HOME/.config/omarchy/hooks/theme-set"
if [[ -f "$HOOK_FILE" ]]; then
  if grep -q "omarchy-lazygit-theme-apply\|omarchy-delta-theme-apply" "$HOOK_FILE" 2>/dev/null; then
    sed -i '/# >>> omarchy-theme-sync hook >>>/,/# <<< omarchy-theme-sync hook <<</d' "$HOOK_FILE"
    echo "✓ Removed hook from theme-set"
  fi
fi

echo ""
echo "✓ Uninstallation complete!"
