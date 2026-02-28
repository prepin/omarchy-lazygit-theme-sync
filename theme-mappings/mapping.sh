#!/bin/bash
# Theme mappings for lazygit - maps Omarchy colors to lazygit theme attributes

# This script determines the best color mapping for each theme based on:
# 1. Contrast requirements
# 2. Official theme implementations
# 3. Visual consistency

get_theme_mapping() {
  local theme=$1
  
  case $theme in
    catppuccin)
      # Dark theme similar to Catppuccin Mocha
      cat << 'YAML'
activeBorderColor: accent
inactiveBorderColor: color0
optionsTextColor: accent
selectedLineBgColor: color0
cherryPickedCommitBgColor: color0
cherryPickedCommitFgColor: selection_foreground
unstagedChangesColor: color1
defaultFgColor: foreground
searchingActiveBorderColor: color3
authorColors: accent
YAML
      ;;
    catppuccin-latte)
      # Light theme - matches official Catppuccin Latte
      cat << 'YAML'
activeBorderColor: accent
inactiveBorderColor: color15
optionsTextColor: accent
selectedLineBgColor: color8
cherryPickedCommitBgColor: color0
cherryPickedCommitFgColor: selection_foreground
unstagedChangesColor: color1
defaultFgColor: foreground
searchingActiveBorderColor: color3
authorColors: accent
YAML
      ;;
    tokyo-night)
      # Dark theme with good contrast
      cat << 'YAML'
activeBorderColor: accent
inactiveBorderColor: color0
optionsTextColor: accent
selectedLineBgColor: color0
cherryPickedCommitBgColor: color0
cherryPickedCommitFgColor: selection_foreground
unstagedChangesColor: color1
defaultFgColor: foreground
searchingActiveBorderColor: color3
authorColors: accent
YAML
      ;;
    nord)
      # Cold dark theme
      cat << 'YAML'
activeBorderColor: accent
inactiveBorderColor: color0
optionsTextColor: accent
selectedLineBgColor: color8
cherryPickedCommitBgColor: color8
cherryPickedCommitFgColor: foreground
unstagedChangesColor: color1
defaultFgColor: foreground
searchingActiveBorderColor: color3
authorColors: accent
YAML
      ;;
    gruvbox)
      # Warm dark theme
      cat << 'YAML'
activeBorderColor: accent
inactiveBorderColor: color0
optionsTextColor: accent
selectedLineBgColor: color0
cherryPickedCommitBgColor: color0
cherryPickedCommitFgColor: selection_foreground
unstagedChangesColor: color1
defaultFgColor: foreground
searchingActiveBorderColor: color3
authorColors: accent
YAML
      ;;
    everforest)
      # Green-based dark theme
      cat << 'YAML'
activeBorderColor: accent
inactiveBorderColor: color0
optionsTextColor: accent
selectedLineBgColor: color8
cherryPickedCommitBgColor: color8
cherryPickedCommitFgColor: foreground
unstagedChangesColor: color1
defaultFgColor: foreground
searchingActiveBorderColor: color3
authorColors: accent
YAML
      ;;
    kanagawa)
      # Japanese-inspired dark theme
      cat << 'YAML'
activeBorderColor: accent
inactiveBorderColor: color0
optionsTextColor: accent
selectedLineBgColor: color8
cherryPickedCommitBgColor: color8
cherryPickedCommitFgColor: selection_foreground
unstagedChangesColor: color1
defaultFgColor: foreground
searchingActiveBorderColor: color3
authorColors: accent
YAML
      ;;
    rose-pine)
      # Light warm theme
      cat << 'YAML'
activeBorderColor: accent
inactiveBorderColor: color8
optionsTextColor: accent
selectedLineBgColor: color8
cherryPickedCommitBgColor: color0
cherryPickedCommitFgColor: foreground
unstagedChangesColor: color1
defaultFgColor: foreground
searchingActiveBorderColor: color3
authorColors: accent
YAML
      ;;
    white)
      # Pure white theme - needs dark selection
      cat << 'YAML'
activeBorderColor: color0
inactiveBorderColor: color0
optionsTextColor: color0
selectedLineBgColor: color0
cherryPickedCommitBgColor: color0
cherryPickedCommitFgColor: foreground
unstagedChangesColor: color1
defaultFgColor: foreground
searchingActiveBorderColor: color3
authorColors: color0
YAML
      ;;
    vantablack)
      # Almost black theme - needs light selection
      cat << 'YAML'
activeBorderColor: color8
inactiveBorderColor: color0
optionsTextColor: color8
selectedLineBgColor: color8
cherryPickedCommitBgColor: color8
cherryPickedCommitFgColor: foreground
unstagedChangesColor: color1
defaultFgColor: foreground
searchingActiveBorderColor: color3
authorColors: color8
YAML
      ;;
    *)
      # Default mapping for other themes
      cat << 'YAML'
activeBorderColor: accent
inactiveBorderColor: color0
optionsTextColor: accent
selectedLineBgColor: color0
cherryPickedCommitBgColor: color0
cherryPickedCommitFgColor: selection_foreground
unstagedChangesColor: color1
defaultFgColor: foreground
searchingActiveBorderColor: color3
authorColors: accent
YAML
      ;;
  esac
}

# Run function if called directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  get_theme_mapping "$1"
fi
