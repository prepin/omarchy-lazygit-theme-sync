#!/bin/bash
# Preset-based theme generation with optimal color mappings

# Each theme has its own optimal mapping based on official implementations
# and contrast requirements

get_theme_preset() {
  local theme=$1
  
  case $theme in
    catppuccin)
      # Catppuccin Mocha (dark) - based on official implementation
      cat << 'PRESET'
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
PRESET
      ;;
    catppuccin-latte)
      # Catppuccin Latte (light) - matches official exactly
      cat << 'PRESET'
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
PRESET
      ;;
    tokyo-night)
      # Tokyo Night - optimized for this color palette
      cat << 'PRESET'
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
PRESET
      ;;
    nord)
      # Nord - matches official implementation
      cat << 'PRESET'
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
PRESET
      ;;
    gruvbox)
      # Gruvbox - warm tones with good contrast
      cat << 'PRESET'
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
PRESET
      ;;
    everforest)
      # Everforest - green-based
      cat << 'PRESET'
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
PRESET
      ;;
    kanagawa)
      # Kanagawa - Japanese aesthetics
      cat << 'PRESET'
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
PRESET
      ;;
    rose-pine)
      # Rose Pine - light warm theme
      cat << 'PRESET'
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
PRESET
      ;;
    white)
      # White - pure light theme with dark selection
      cat << 'PRESET'
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
PRESET
      ;;
    vantablack)
      # Vantablack - near-black with light selection
      cat << 'PRESET'
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
PRESET
      ;;
    *)
      # Default preset for unknown themes
      cat << 'PRESET'
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
PRESET
      ;;
  esac
}

# Run if called directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  get_theme_preset "$1"
fi
