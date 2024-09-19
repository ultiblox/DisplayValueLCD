#!/bin/bash

# Set the location where the DisplayValueCommon library should be installed
LIBRARY_PATH="./libraries/DisplayValueCommon"

# Check if DisplayValueCommon is already present
if [ ! -d "$LIBRARY_PATH" ]; then
    echo "Cloning DisplayValueCommon library..."
    git clone https://github.com/makers-multiverse/DisplayValueCommon.git "$LIBRARY_PATH"
else
    echo "DisplayValueCommon library already exists, skipping clone."
fi

echo "Library preparation complete."
