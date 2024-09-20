#!/bin/bash

# Function to clone libraries if not already present
install_library() {
  local LIBRARY_NAME="$1"
  local LIBRARY_PATH="$HOME/Arduino/libraries/$LIBRARY_NAME"
  local GIT_URL="$2"

  if [ ! -d "$LIBRARY_PATH" ]; then
    echo "Cloning $LIBRARY_NAME into Arduino libraries folder..."
    git clone "$GIT_URL" "$LIBRARY_PATH"
  else
    echo "$LIBRARY_NAME already exists, skipping clone."
  fi
}

# Install required libraries
install_library "DisplayValueCommon" "https://github.com/makers-multiverse/DisplayValueCommon.git"
install_library "LCDI2C" "https://github.com/makers-multiverse/LCDI2C.git"
install_library "SerialLogger" "https://github.com/makers-multiverse/SerialLogger.git"

# Finish


echo "Library preparation complete."
