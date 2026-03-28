#!/bin/bash
set -e

log_info() {
  echo "[INFO] $*"
}

log_success() {
  echo "[SUCCESS] $*"
}

log_info "Uninstalling omarchy-lazygit-theme-sync"

# Remove lazygit scripts
for script in omarchy-lazygit-theme-apply omarchy-lazygit-theme-generate; do
  if [[ -f ~/.local/bin/$script ]]; then
    rm ~/.local/bin/$script
    log_success "Removed $script"
  fi
done

# Remove lazygit wrapper
if [[ -f ~/.local/bin/lazygit ]]; then
  if head -2 ~/.local/bin/lazygit | grep -q "Omarchy lazygit wrapper"; then
    rm ~/.local/bin/lazygit
    log_success "Removed lazygit wrapper"
  fi
fi

# Remove lazygit themes
if [[ -d ~/.config/omarchy/lazygit-themes ]]; then
  rm -rf ~/.config/omarchy/lazygit-themes
  log_success "Removed lazygit themes"
fi

# Remove lazygit theme file
if [[ -f ~/.config/lazygit/theme.yml ]]; then
  rm ~/.config/lazygit/theme.yml
  log_success "Removed lazygit theme file"
fi

# Remove hook from theme-set
HOOK_FILE="$HOME/.config/omarchy/hooks/theme-set"
if [[ -f "$HOOK_FILE" ]]; then
  if grep -q "omarchy-lazygit-theme-apply" "$HOOK_FILE" 2>/dev/null; then
    sed -i '/# >>> omarchy-lazygit-theme-sync hook >>>/,/# <<< omarchy-lazygit-theme-sync hook <<</d' "$HOOK_FILE"
    log_success "Removed hook from theme-set"
  fi
fi

log_success "Uninstallation complete"
