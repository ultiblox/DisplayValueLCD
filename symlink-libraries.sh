#!/bin/bash

# Define the source path for the AnalogSensor library using a relative path
LIBRARY_PATH="$PWD"

# Define the target path where the symlink will be created
# This should be in a 'libraries' directory if adhering to Arduino project structure
TARGET_PATH="/home/$USER/Arduino/libraries/LCD1602Display"

# Ensure the target directory exists
mkdir -p $(dirname "${TARGET_PATH}")

# Check if the symlink already exists
if [ -L "${TARGET_PATH}" ] || [ -d "${TARGET_PATH}" ]; then
    echo "Symlink or directory already exists."
else
    # Create the symbolic link
    ln -r -s ${LIBRARY_PATH} ${TARGET_PATH}
    echo "Symlink created at ${TARGET_PATH} pointing to ${LIBRARY_PATH}"
fi
