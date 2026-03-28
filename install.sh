#!/bin/bash
set -e

log_info() {
  echo "[INFO] $*"
}

log_success() {
  echo "[SUCCESS] $*"
}

log_warn() {
  echo "[WARN] $*"
}

log_info "Installing omarchy-lazygit-theme-sync"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Copy lazygit scripts
cp "$SCRIPT_DIR/scripts/lazygit-theme-apply.sh" ~/.local/bin/omarchy-lazygit-theme-apply
chmod +x ~/.local/bin/omarchy-lazygit-theme-apply

cp "$SCRIPT_DIR/scripts/lazygit-theme-generate.sh" ~/.local/bin/omarchy-lazygit-theme-generate
chmod +x ~/.local/bin/omarchy-lazygit-theme-generate

# Copy lazygit wrapper
cp "$SCRIPT_DIR/wrappers/lazygit" ~/.local/bin/lazygit
chmod +x ~/.local/bin/lazygit

# Copy bundled themes
mkdir -p ~/.config/omarchy/lazygit-themes
cp "$SCRIPT_DIR/themes/"*.yml ~/.config/omarchy/lazygit-themes/

# Add hook to theme-set
HOOK_FILE="$HOME/.config/omarchy/hooks/theme-set"
if [[ -f "$HOOK_FILE" ]]; then
  if ! grep -q "omarchy-lazygit-theme-apply" "$HOOK_FILE" 2>/dev/null; then
    cat "$SCRIPT_DIR/hooks-append/theme-set" >> "$HOOK_FILE"
    log_success "Hook added to theme-set"
  else
    log_info "Hook already present"
  fi
else
  log_warn "theme-set hook file not found"
fi

# Apply current theme
CURRENT_THEME=$(cat ~/.config/omarchy/current/theme.name 2>/dev/null || echo "catppuccin")
if [[ -f ~/.local/bin/omarchy-lazygit-theme-apply ]]; then
  ~/.local/bin/omarchy-lazygit-theme-apply "$CURRENT_THEME"
fi

log_success "Installation complete"
log_info "Lazygit now syncs automatically with Omarchy theme changes"
