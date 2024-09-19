#!/bin/bash

# Define the Arduino libraries folder
LIBRARY_PATH1="$HOME/Arduino/libraries/DisplayValueCommon"

# Check if DisplayValueCommon is already present
if [ ! -d "$LIBRARY_PATH1" ]; then
    echo "Cloning DisplayValueCommon library into Arduino libraries folder..."
    git clone https://github.com/makers-multiverse/DisplayValueCommon.git "$LIBRARY_PATH"
else
    echo "DisplayValueCommon library already exists, skipping clone."
fi

# Define the Arduino libraries folder
LIBRARY_PATH2="$HOME/Arduino/libraries/LCDI2C"

# Check if LCDI2C is already present
if [ ! -d "$LIBRARY_PATH2" ]; then
    echo "Cloning LCDI2C library into Arduino libraries folder..."
    git clone https://github.com/makers-multiverse/LCDI2C.git "$LIBRARY_PATH"
else
    echo "LCDI2C library already exists, skipping clone."
fi

echo "Library preparation complete."
