#!/bin/bash
# Simple passthrough - all logic is in generator script

get_theme_mapping() {
  # No longer needed - generator handles everything
  echo "activeBorderColor: accent"
  echo "inactiveBorderColor: foreground"
  echo "optionsTextColor: accent"
  echo "selectedLineBgColor: selection_background"
  echo "cherryPickedCommitBgColor: selection_background"
  echo "cherryPickedCommitFgColor: foreground"
  echo "unstagedChangesColor: color1"
  echo "defaultFgColor: foreground"
  echo "searchingActiveBorderColor: color3"
  echo "authorColors: accent"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  get_theme_mapping
fi
