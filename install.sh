#!/bin/bash

# Load environment variables
source ./env.sh

# Ensure the Arduino libraries directory exists
if [ ! -d "$ARDUINO_LIBRARIES_DIR" ]; then
    echo "Error: Arduino libraries directory not found at $ARDUINO_LIBRARIES_DIR"
    exit 1
fi

# Install each dependency
DEPENDENCIES_FILE="./dependencies.txt"
while IFS=',' read -r DEP_NAME GIT_URL || [ -n "$DEP_NAME" ]; do
    # Trim spaces and handle carriage returns
    DEP_NAME=$(echo "${DEP_NAME}" | tr -d '\r' | sed 's/^[ \t]*//;s/[ \t]*$//')
    GIT_URL=$(echo "${GIT_URL}" | tr -d '\r' | sed 's/^[ \t]*//;s/[ \t]*$//')

    # Skip empty or invalid lines
    if [[ -z "$DEP_NAME" || -z "$GIT_URL" ]]; then
        echo "Skipping empty or invalid line"
        continue
    fi

    # Determine the target name with prefix
    if [[ "$DEP_NAME" == UltiBlox-* ]]; then
        TARGET_NAME="$DEP_NAME"
    else
        TARGET_NAME="UltiBlox-$DEP_NAME"
    fi
    TARGET_PATH="$ARDUINO_LIBRARIES_DIR/$TARGET_NAME"

    if [ -d "$(dirname "$(pwd)")/$DEP_NAME" ]; then
        echo "Installing dependency: $DEP_NAME as $TARGET_NAME"
        cp -r "$(dirname "$(pwd)")/$DEP_NAME" "$TARGET_PATH" || {
            echo "Error: Failed to install $DEP_NAME."
            continue
        }
    else
        echo "Warning: Dependency $DEP_NAME not found. Ensure prepare-libraries.sh has been run."
    fi
done < "$DEPENDENCIES_FILE"

# Install the current library
cp -r "$(pwd)" "$ARDUINO_LIBRARIES_DIR/$LIBRARY_NAME" || {
    echo "Error: Failed to install $LIBRARY_NAME."
    exit 1
}

echo "$LIBRARY_NAME and its dependencies installed successfully to $ARDUINO_LIBRARIES_DIR."