#!/bin/bash

# Loop through all subdirectories in UltiBloxExamples/examples and modify DisplayConfig.h to enable LCD display
EXAMPLES_DIR="/tmp/ultiblox/UltiBloxExamples/examples"

# Iterate over each example folder
for example in "$EXAMPLES_DIR"/*; do
  CONFIG_PATH="$example/DisplayConfig.h"
  
  echo "DEBUG: Looking for DisplayConfig.h at $CONFIG_PATH"
  if [ -f "$CONFIG_PATH" ]; then
    echo "Found DisplayConfig.h in $example. Checking and modifying..."
    
    # Show current ACTIVE_DISPLAY_TYPE line for verification
    grep "#define ACTIVE_DISPLAY_TYPE" "$CONFIG_PATH"
    
    # Modify the display type to LCD
    sed -i 's|^#define ACTIVE_DISPLAY_TYPE .*|#define ACTIVE_DISPLAY_TYPE DISPLAY_TYPE_LCD|' "$CONFIG_PATH"
    
    # Confirm modification by showing the updated line
    echo "Updated ACTIVE_DISPLAY_TYPE line in $CONFIG_PATH:"
    grep "#define ACTIVE_DISPLAY_TYPE" "$CONFIG_PATH"

    # Check if the modification was successful and report
    if grep -q '#define ACTIVE_DISPLAY_TYPE DISPLAY_TYPE_LCD' "$CONFIG_PATH"; then
      echo "Modification successful for $CONFIG_PATH"
    else
      echo "Warning: Modification may not have applied to $CONFIG_PATH"
    fi
  else
    echo "No DisplayConfig.h found in $example, skipping."
  fi

done
