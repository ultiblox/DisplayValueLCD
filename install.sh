#!/bin/bash

# Set Arduino libraries folder (default for Linux)
ARDUINO_LIBRARIES_DIR="$HOME/Arduino/libraries"

# Check if Arduino libraries folder exists
if [ ! -d "$ARDUINO_LIBRARIES_DIR" ]; then
    echo "Error: Arduino libraries directory not found at $ARDUINO_LIBRARIES_DIR"
    exit 1
fi

# Copy the current library to Arduino libraries folder
LIBRARY_NAME="DisplayValueLCD"
cp -r "$(pwd)" "$ARDUINO_LIBRARIES_DIR/$LIBRARY_NAME"

echo "$LIBRARY_NAME installed successfully to $ARDUINO_LIBRARIES_DIR"
