#!/bin/bash
# Omarchy Lazygit Theme Sync - Installation Script

set -e

echo "=== Omarchy Lazygit Theme Sync - Installation ==="
echo ""

# Check if lazygit is installed
if ! command -v lazygit &>/dev/null; then
  echo "Error: lazygit is not installed"
  echo "Please install lazygit first: pacman -S lazygit"
  exit 1
fi

# Check if yq is installed
if ! command -v yq &>/dev/null; then
  echo "Error: yq is not installed"
  echo "Please install yq first: pacman -S go-yq or visit https://github.com/mikefarah/yq"
  exit 1
fi

# Determine installation directory
INSTALL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "Installing from: $INSTALL_DIR"

# Step 1: Create directories
echo ""
echo "[1/7] Creating directories..."
mkdir -p ~/.config/lazygit
mkdir -p ~/.config/omarchy/lazygit-themes
mkdir -p ~/.local/bin
mkdir -p ~/.local/share/omarchy-lazygit-theme-sync
echo "✓ Directories created"

# Step 2: Backup existing lazygit config
echo ""
echo "[2/7] Backing up existing lazygit config..."
if [[ -f ~/.config/lazygit/config.yml ]]; then
  BACKUP_FILE="$HOME/.config/lazygit/config.yml.bak.$(date +%s)"
  cp ~/.config/lazygit/config.yml "$BACKUP_FILE"
  echo "✓ Backed up existing config to: $BACKUP_FILE"
fi

# Ensure main config exists (create from default if needed)
if [[ ! -f ~/.config/lazygit/config.yml ]]; then
  echo "Creating default lazygit config..."
  lazygit --config > ~/.config/lazygit/config.yml
  echo "✓ Created default config"
fi

# Step 3: Install bundled themes
echo ""
echo "[3/7] Installing bundled lazygit themes..."
cp "$INSTALL_DIR/themes/"*.yml ~/.config/omarchy/lazygit-themes/
echo "✓ Installed $(ls ~/.config/omarchy/lazygit-themes/ | wc -l) theme files"

# Step 4: Install scripts
echo ""
echo "[4/7] Installing scripts..."

# Theme apply script
chmod +x "$INSTALL_DIR/scripts/lazygit-theme-apply.sh"
cp "$INSTALL_DIR/scripts/lazygit-theme-apply.sh" ~/.local/bin/omarchy-lazygit-theme-apply
echo "✓ Installed omarchy-lazygit-theme-apply"

# Theme generate script
chmod +x "$INSTALL_DIR/scripts/lazygit-theme-generate.sh"
cp "$INSTALL_DIR/scripts/lazygit-theme-generate.sh" ~/.local/bin/omarchy-lazygit-theme-generate
echo "✓ Installed omarchy-lazygit-theme-generate"

# Step 5: Install wrapper script
echo ""
echo "[5/7] Installing lazygit wrapper..."
if [[ -f ~/.local/bin/lazygit ]]; then
  echo "Warning: ~/.local/bin/lazygit already exists"
  BACKUP_WRAPPER="$HOME/.local/bin/lazygit.bak.$(date +%s)"
  cp ~/.local/bin/lazygit "$BACKUP_WRAPPER"
  echo "✓ Backed up existing wrapper to: $BACKUP_WRAPPER"
fi

chmod +x "$INSTALL_DIR/wrappers/lazygit"
cp "$INSTALL_DIR/wrappers/lazygit" ~/.local/bin/lazygit
echo "✓ Installed lazygit wrapper"

# Step 6: Install templates
echo ""
echo "[6/7] Installing templates..."
cp "$INSTALL_DIR/templates/"*.yml.tpl "$HOME/.local/share/omarchy-lazygit-theme-sync/"
echo "✓ Installed templates"

# Step 7: Install hook
echo ""
echo "[7/7] Installing Omarchy hook..."
if [[ -f ~/.config/omarchy/hooks/theme-set ]]; then
  # Check if hook is already installed
  if grep -q "omarchy-lazygit-theme-sync hook" ~/.config/omarchy/hooks/theme-set; then
    echo "✓ Hook already installed, skipping"
  else
    cat "$INSTALL_DIR/hooks-append/theme-set" >> ~/.config/omarchy/hooks/theme-set
    echo "✓ Hook appended to theme-set"
  fi
else
  echo "Warning: ~/.config/omarchy/hooks/theme-set not found"
  echo "Please create it and add the hook manually"
fi

# Apply current theme
echo ""
echo "Applying current Omarchy theme to lazygit..."
if [[ -f ~/.config/omarchy/current/theme.name ]]; then
  CURRENT_THEME=$(cat ~/.config/omarchy/current/theme.name)
  ~/.local/bin/omarchy-lazygit-theme-apply "$CURRENT_THEME"
else
  echo "Warning: Could not determine current Omarchy theme"
fi

echo ""
echo "=== Installation Complete! ==="
echo ""
echo "What's installed:"
echo "  - Lazygit wrapper at: ~/.local/bin/lazygit"
echo "  - Theme scripts in: ~/.local/bin/"
echo "  - Bundled themes in: ~/.config/omarchy/lazygit-themes/"
echo "  - Theme output at: ~/.config/lazygit/theme.yml"
echo ""
echo "How it works:"
echo "  - When you run 'omarchy-theme-set <theme>', the lazygit theme is automatically updated"
echo "  - Lazygit will load the new theme the next time you open it"
echo ""
echo "To disable automatic theme sync:"
echo "  mkdir -p ~/.config/omarchy/toggles"
echo "  touch ~/.config/omarchy/toggles/skip-lazygit-theme"
echo ""
echo "To uninstall, run: ./uninstall.sh"
