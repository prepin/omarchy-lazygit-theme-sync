# Omarchy Lazygit Theme Sync

Automatic theme synchronization for lazygit with Omarchy themes. When you change your Omarchy theme, lazygit will automatically update to match.

## Features

- **Automatic theme sync**: lazygit theme updates automatically when you change Omarchy themes
- **Bundled themes**: Includes curated lazygit themes for all 17 built-in Omarchy themes
- **Custom theme support**: Generates lazygit themes from any Omarchy theme's `colors.toml`
- **Non-destructive**: Uses a separate theme file, never modifies your main lazygit config
- **Live reload**: Theme applies immediately when you open lazygit
- **Easy customization**: Add your own lazygit themes to `~/.config/omarchy/lazygit-themes/`
- **Toggle support**: Easily disable automatic theme sync if needed

## Supported Omarchy Themes

All 17 built-in Omarchy themes are supported:

- catppuccin
- catppuccin-latte
- ethereal
- everforest
- flexoki-light
- gruvbox
- hackerman
- kanagawa
- matte-black
- miasma
- nord
- osaka-jade
- ristretto
- rose-pine
- tokyo-night
- vantablack
- white

## Requirements

- **lazygit**: Terminal UI for git commands
- **yq**: YAML processor (install with `pacman -S go-yq`)
- **Omarchy**: Linux distribution with theme system

## Installation

### Quick Install

```bash
# Clone or download this package
cd omarchy-lazygit-theme-sync

# Run the install script
./install.sh
```

### What Gets Installed

1. **Lazygit wrapper** (`~/.local/bin/lazygit`): Automatically loads theme config
2. **Theme scripts** (`~/.local/bin/`): Apply and generate lazygit themes
3. **Bundled themes** (`~/.config/omarchy/lazygit-themes/`): Curated lazygit themes
4. **Templates** (`~/.local/share/omarchy-lazygit-theme-sync/`): Theme generation templates
5. **Hook** (`~/.config/omarchy/hooks/theme-set`): Triggers on Omarchy theme change
6. **Theme config** (`~/.config/lazygit/theme.yml`): Auto-generated lazygit theme

### How It Works

```
User runs: omarchy-theme-set catppuccin
    ↓
omarchy-theme-set calls: omarchy-hook theme-set "catppuccin"
    ↓
Our hook runs: omarchy-lazygit-theme-apply "catppuccin"
    ↓
Script finds bundled theme and copies to ~/.config/lazygit/theme.yml
    ↓
User opens lazygit (wrapper loads both configs)
    ↓
Lazygit displays catppuccin theme!
```

## Usage

### Automatic Theme Sync

After installation, theme sync happens automatically:

```bash
# Change your Omarchy theme
omarchy-theme-set tokyo-night

# Open lazygit - it will now use the tokyo-night theme
lazygit
```

### Manual Theme Control

```bash
# Apply a specific lazygit theme manually
omarchy-lazygit-theme-apply catppuccin

# List available lazygit themes
ls ~/.config/omarchy/lazygit-themes/

# Check current lazygit theme
cat ~/.config/lazygit/theme.yml
```

### Disable Automatic Theme Sync

```bash
# Create skip file to disable auto-sync
mkdir -p ~/.config/omarchy/toggles
touch ~/.config/omarchy/toggles/skip-lazygit-theme

# Re-enable by removing the file
rm ~/.config/omarchy/toggles/skip-lazygit-theme
```

### Add Custom Lazygit Themes

```bash
# Add a custom lazygit theme
cp my-custom-theme.yml ~/.config/omarchy/lazygit-themes/my-theme.yml

# Apply it manually
omarchy-lazygit-theme-apply my-theme
```

## Configuration

### File Locations

| File | Purpose | Editable |
|------|---------|----------|
| `~/.config/lazygit/config.yml` | Main lazygit config | ✅ Yes |
| `~/.config/lazygit/theme.yml` | Theme config (auto-generated) | ⚠️ Overwritten on theme change |
| `~/.config/omarchy/lazygit-themes/` | Bundled lazygit themes | ✅ Yes |
| `~/.local/bin/lazygit` | Wrapper script | ⚠️ Changes may break sync |
| `~/.config/omarchy/toggles/skip-lazygit-theme` | Disable auto-sync | ✅ Yes |

### Theme Configuration Structure

The lazygit theme config follows the official lazygit theme format:

```yaml
gui:
  theme:
    activeBorderColor:
      - '#7aa2f7'
      - bold
    inactiveBorderColor:
      - '#a9b1d6'
    optionsTextColor:
      - '#7aa2f7'
    selectedLineBgColor:
      - '#7aa2f7'
    cherryPickedCommitBgColor:
      - '#7aa2f7'
    cherryPickedCommitFgColor:
      - '#7aa2f7'
    unstagedChangesColor:
      - '#f7768e'
    defaultFgColor:
      - '#a9b1d6'
    searchingActiveBorderColor:
      - '#e0af68'
      - bold
    authorColors:
      '*': '#7aa2f7'
```

### Color Mapping (Generated Themes)

When generating themes from Omarchy's `colors.toml`, colors are mapped as follows:

| Lazygit Attribute | Omarchy Color |
|-------------------|---------------|
| activeBorderColor | accent |
| inactiveBorderColor | foreground |
| optionsTextColor | accent |
| selectedLineBgColor | selection_background |
| cherryPickedCommitBgColor | selection_background |
| cherryPickedCommitFgColor | accent |
| unstagedChangesColor | color1 (typically red) |
| defaultFgColor | foreground |
| searchingActiveBorderColor | color3 (typically yellow) |
| authorColors.\* | accent |

## Troubleshooting

### Lazygit not using the theme

**Symptom**: lazygit opens with default theme instead of Omarchy theme

**Solutions**:
1. Check if wrapper is being used:
   ```bash
   which lazygit
   # Should output: ~/.local/bin/lazygit
   ```
2. Verify theme file exists:
   ```bash
   cat ~/.config/lazygit/theme.yml
   ```
3. Check for skip toggle:
   ```bash
   ls ~/.config/omarchy/toggles/skip-lazygit-theme 2>/dev/null
   ```
4. Reapply current theme manually:
   ```bash
   CURRENT_THEME=$(cat ~/.config/omarchy/current/theme.name)
   omarchy-lazygit-theme-apply "$CURRENT_THEME"
   ```

### Theme doesn't update after changing Omarchy theme

**Symptom**: Changed Omarchy theme but lazygit still shows old theme

**Solutions**:
1. Close and reopen lazygit (theme applies on next launch)
2. Check hook is installed:
   ```bash
   tail -10 ~/.config/omarchy/hooks/theme-set
   ```
3. Manually trigger theme apply:
   ```bash
   omarchy-lazygit-theme-apply <theme-name>
   ```

### Wrapper conflicts with existing setup

**Symptom**: Already have a custom `~/.local/bin/lazygit` wrapper

**Solutions**:
1. The install script will backup your existing wrapper
2. Merge your wrapper logic with our wrapper
3. Or manually call lazygit with both configs:
   ```bash
   /usr/bin/lazygit --use-config-file="~/.config/lazygit/config.yml,~/.config/lazygit/theme.yml"
   ```

### Custom theme not found

**Symptom**: Using a custom Omarchy theme and lazygit shows default theme

**Solutions**:
1. Ensure your theme has `colors.toml`:
   ```bash
   ls ~/.config/omarchy/current/theme/colors.toml
   ```
2. Manually generate the theme:
   ```bash
   ~/.local/bin/omarchy-lazygit-theme-generate \
     ~/.config/omarchy/current/theme/colors.toml \
     > ~/.config/lazygit/theme.yml
   ```
3. Or create a lazygit theme for it:
   ```bash
   cp ~/.config/lazygit/theme.yml \
     ~/.config/omarchy/lazygit-themes/my-theme.yml
   ```

## Uninstallation

```bash
cd omarchy-lazygit-theme-sync

# Run the uninstall script
./uninstall.sh
```

The uninstall script:
- Removes the lazygit wrapper
- Removes theme scripts
- Removes bundled themes
- Removes theme config
- Removes templates
- Removes hook code from theme-set
- Preserves your main lazygit config

After uninstallation, you can clean up backup files:
```bash
# Remove lazygit config backups
rm ~/.config/lazygit/config.yml.bak.*

# Remove hook backups
rm ~/.config/omarchy/hooks/theme-set.bak.*
```

## Development

### Regenerating Bundled Themes

To regenerate all bundled lazygit themes from Omarchy themes:

```bash
./generate-themes.sh
```

This script:
- Reads all Omarchy themes from `~/.local/share/omarchy/themes/`
- Generates lazygit themes using the color mapping template
- Outputs to `themes/` directory

### Adding a New Omarchy Theme

When a new Omarchy theme is added:

1. Generate the lazygit theme:
   ```bash
   ./generate-themes.sh
   ```
2. Or manually create a theme file:
   ```bash
   cp templates/lazygit-theme.yml.tpl themes/new-theme.yml
   # Edit the theme with actual colors
   ```
3. Test the theme:
   ```bash
   omarchy-lazygit-theme-apply new-theme
   lazygit
   ```

### Project Structure

```
omarchy-lazygit-theme-sync/
├── install.sh                    # Installation script
├── uninstall.sh                  # Uninstallation script
├── generate-themes.sh            # Generate all themes from Omarchy
├── themes/                       # Bundled lazygit themes (17 files)
│   ├── catppuccin.yml
│   ├── tokyo-night.yml
│   └── ...
├── scripts/
│   ├── lazygit-theme-apply.sh  # Apply theme to lazygit
│   └── lazygit-theme-generate.sh # Generate theme from colors.toml
├── wrappers/
│   └── lazygit                  # Wrapper script
├── hooks-append/
│   └── theme-set                # Hook code to append
├── templates/
│   └── lazygit-theme.yml.tpl   # Theme generation template
└── README.md                    # This file
```

## License

This package follows the same license as Omarchy (MIT License).

## Contributing

Contributions are welcome! Areas for improvement:
- Add curated lazygit themes from community sources
- Improve color mapping for better theme generation
- Add support for light/dark theme variants
- Add more lazygit theme attributes

## Credits

- **Omarchy**: The beautiful Linux distribution this integrates with
- **lazygit**: The terminal UI for git operations
- **Catppuccin**: For the catppuccin lazygit theme inspiration
- All theme creators who made their themes available

## Support

For issues specific to this package, please open an issue in the repository where you found it.

For Omarchy-specific issues, visit: https://omarchy.org/

For lazygit issues, visit: https://github.com/jesseduffield/lazygit

## Delta (Git Diff) Theme Sync

As of version 2.0, this package also includes **delta theme synchronization**!

### What is Delta?

Delta is a syntax-highlighting pager for git diff output. It makes git diffs more readable with colors and formatting.

### Features

- **Automatic sync**: Delta colors update when you change Omarchy themes
- **Syntax highlighting**: Code syntax is highlighted with your theme colors
- **Smart contrast**: Colors are adjusted for light/dark themes automatically
- **Non-destructive**: Uses gitconfig include, doesn't modify your main config

### Delta Colors

Delta uses these Omarchy theme colors:

| Delta Element | Omarchy Color | Description |
|---------------|---------------|-------------|
| **minus-style** | color1 (red) | Removed lines |
| **plus-style** | color2 (green) | Added lines |
| **file-style** | accent | File names |
| **hunk-header-style** | color3 (yellow) | Hunk headers |
| **grep-file-style** | color5 (magenta) | Grep results |

### How It Works

1. Script generates `~/.config/delta/themes/omarchy.gitconfig`
2. Adds include to `~/.gitconfig`
3. Delta automatically uses theme on next run

### For Dark Themes

- Uses alpha transparency for backgrounds
- Lighter variations of red/green for visibility
- Example: `#f49cb53f` (red with 25% alpha)

### For Light Themes

- Uses darker solid colors for contrast
- Darker variations of red/green
- Example: `#9d0b2a` (dark red)

### Testing

Test delta theme:

```bash
# Create test files
echo "test line 1" > /tmp/test1.txt
echo "test line 1 modified" > /tmp/test2.txt
echo "test line 2" >> /tmp/test2.txt

# View diff with delta
delta /tmp/test1.txt /tmp/test2.txt
```

### Manual Theme Application

```bash
# Apply specific theme
~/.local/bin/omarchy-delta-theme-apply catppuccin

# Apply current Omarchy theme
~/.local/bin/omarchy-delta-theme-apply
```

### Customization

Delta theme file is auto-generated. To customize:

1. Edit `~/.local/bin/omarchy-delta-theme-apply`
2. Modify color mappings in `generate_delta_theme()` function
3. Run script to regenerate theme

### Disabling Delta Theme Sync

To disable delta theme sync:

1. Remove hook from `~/.config/omarchy/hooks/theme-set`:
   ```bash
   sed -i '/# >>> omarchy-delta-theme-sync hook >>>/,/# <<< omarchy-delta-theme-sync hook <<</d' \
     ~/.config/omarchy/hooks/theme-set
   ```

2. Remove include from `~/.gitconfig`:
   ```bash
   sed -i '/# >>> omarchy-delta-theme-sync >>>/,/# <<< omarchy-delta-theme-sync <<</d' \
     ~/.gitconfig
   ```

3. Delete delta theme:
   ```bash
   rm ~/.config/delta/themes/omarchy.gitconfig
   ```

