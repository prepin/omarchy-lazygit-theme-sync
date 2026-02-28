#!/bin/bash
# Omarchy Lazygit Theme Sync - Uninstallation Script

set -e

echo "=== Omarchy Lazygit Theme Sync - Uninstallation ==="
echo ""

# Determine installation directory
INSTALL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Step 1: Remove wrapper
echo "[1/6] Removing lazygit wrapper..."
if [[ -f ~/.local/bin/lazygit ]]; then
  # Check if it's our wrapper (look for our comment)
  if grep -q "Omarchy lazygit wrapper" ~/.local/bin/lazygit 2>/dev/null; then
    rm ~/.local/bin/lazygit
    echo "✓ Removed lazygit wrapper"
  else
    echo "Warning: ~/.local/bin/lazygit doesn't appear to be our wrapper, skipping"
  fi
else
  echo "ℹ Wrapper not found, skipping"
fi

# Step 2: Remove theme scripts
echo ""
echo "[2/6] Removing theme scripts..."
rm -f ~/.local/bin/omarchy-lazygit-theme-apply
rm -f ~/.local/bin/omarchy-lazygit-theme-generate
echo "✓ Removed theme scripts"

# Step 3: Remove bundled themes
echo ""
echo "[3/6] Removing bundled themes..."
if [[ -d ~/.config/omarchy/lazygit-themes ]]; then
  rm -rf ~/.config/omarchy/lazygit-themes
  echo "✓ Removed bundled themes"
else
  echo "ℹ Bundled themes directory not found, skipping"
fi

# Step 4: Remove theme config
echo ""
echo "[4/6] Removing theme config..."
if [[ -f ~/.config/lazygit/theme.yml ]]; then
  rm -f ~/.config/lazygit/theme.yml
  echo "✓ Removed theme config"
else
  echo "ℹ Theme config not found, skipping"
fi

# Step 5: Remove templates
echo ""
echo "[5/6] Removing templates..."
if [[ -d ~/.local/share/omarchy-lazygit-theme-sync ]]; then
  rm -rf ~/.local/share/omarchy-lazygit-theme-sync
  echo "✓ Removed templates"
else
  echo "ℹ Templates directory not found, skipping"
fi

# Step 6: Remove hook code
echo ""
echo "[6/6] Removing Omarchy hook..."
if [[ -f ~/.config/omarchy/hooks/theme-set ]]; then
  # Create backup before modifying
  cp ~/.config/omarchy/hooks/theme-set ~/.config/omarchy/hooks/theme-set.bak.$(date +%s)

  # Remove our hook code
  if grep -q "omarchy-lazygit-theme-sync hook" ~/.config/omarchy/hooks/theme-set; then
    # Use a pattern to remove the hook section
    sed -i '/# >>> omarchy-lazygit-theme-sync hook >>>/,/# <<< omarchy-lazygit-theme-sync hook <<</d' \
      ~/.config/omarchy/hooks/theme-set
    echo "✓ Removed hook from theme-set"
  else
    echo "ℹ Hook not found, skipping"
  fi
else
  echo "ℹ Hook file not found, skipping"
fi

echo ""
echo "=== Uninstallation Complete! ==="
echo ""
echo "What was removed:"
echo "  - Lazygit wrapper: ~/.local/bin/lazygit"
echo "  - Theme scripts: ~/.local/bin/omarchy-lazygit-theme-apply*"
echo "  - Bundled themes: ~/.config/omarchy/lazygit-themes/"
echo "  - Theme config: ~/.config/lazygit/theme.yml"
echo "  - Templates: ~/.local/share/omarchy-lazygit-theme-sync/"
echo "  - Hook code from: ~/.config/omarchy/hooks/theme-set"
echo ""
echo "What was preserved:"
echo "  - Main lazygit config: ~/.config/lazygit/config.yml"
echo "  - Backups created during installation"
echo ""
echo "To restore lazygit to use system binary:"
echo "  which lazygit"
echo "  # Should now show /usr/bin/lazygit"
echo ""
echo "Backups that can be cleaned up:"
echo "  - ~/.config/lazygit/config.yml.bak.*"
echo "  - ~/.local/bin/lazygit.bak.* (if existed)"
echo "  - ~/.config/omarchy/hooks/theme-set.bak.*"
