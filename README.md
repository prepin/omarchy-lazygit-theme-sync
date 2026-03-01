# Omarchy Lazygit Theme Sync

Automatic theme synchronization for lazygit with Omarchy themes.

## Features
- Automatic sync when Omarchy theme changes
- 17 bundled lazygit themes
- Generate themes from colors.toml
- Live reload with wrapper script

## Requirements
- lazygit
- Omarchy

## Installation

### Manual
```bash
./install.sh
```

### AUR
```bash
yay -S omarchy-lazygit-theme-sync
```

## Usage

After installation, lazygit theme automatically syncs:

```bash
omarchy-theme-set catppuccin
lazygit  # Uses catppuccin theme
```

Manual theme application:
```bash
omarchy-lazygit-theme-apply catppuccin
```

Disable auto-sync:
```bash
touch ~/.config/omarchy/toggles/skip-lazygit-theme
```

## Files

| File | Purpose |
|------|---------|
| ~/.local/bin/lazygit | Wrapper that loads theme |
| ~/.local/bin/omarchy-lazygit-theme-apply | Apply theme |
| ~/.config/omarchy/lazygit-themes/ | Bundled themes |
| ~/.config/lazygit/theme.yml | Current theme |

## Troubleshooting

**Lazygit not using theme:**
```bash
which lazygit  # Should be ~/.local/bin/lazygit
```

**Theme doesn't update:**
```bash
CURRENT_THEME=$(cat ~/.config/omarchy/current/theme.name)
omarchy-lazygit-theme-apply "$CURRENT_THEME"
```

## Uninstall
```bash
./uninstall.sh
```

## License
MIT
