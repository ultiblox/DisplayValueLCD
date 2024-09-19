#!/bin/bash

# Define the Arduino libraries folder
LIBRARY_PATH="$HOME/Arduino/libraries/DisplayValueCommon"

# Check if DisplayValueCommon is already present
if [ ! -d "$LIBRARY_PATH" ]; then
    echo "Cloning DisplayValueCommon library into Arduino libraries folder..."
    git clone https://github.com/makers-multiverse/DisplayValueCommon.git "$LIBRARY_PATH"
else
    echo "DisplayValueCommon library already exists, skipping clone."
fi

echo "Library preparation complete."
