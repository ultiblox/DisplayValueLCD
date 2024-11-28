#!/bin/bash

set -e

# Configuration
TMP_DIR="/tmp/ultiblox"        # Top-level temporary directory for consumer repositories
ORGANIZATION="ultiblox"                    # GitHub organization name for consumer repositories
CONSUMER_REPOS=("UltiBloxExamples")        # List of consumer repositories

# Clean up any existing consumer directory
if [ -d "$TMP_DIR" ]; then
  rm -rf "$TMP_DIR"
fi

# Create a fresh temporary directory
mkdir -p "$TMP_DIR"

# Absolute path to the directory of this script
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Loop through each consumer repository
for REPO in "${CONSUMER_REPOS[@]}"; do
  echo "Cloning $REPO into $TMP_DIR..."
  git clone "https://github.com/$ORGANIZATION/$REPO.git" "$TMP_DIR/$REPO" || { echo "Error: Cloning $REPO failed"; exit 1; }

  # Navigate to the cloned consumer repository
  cd "$TMP_DIR/$REPO" || { echo "Error: Could not enter directory $REPO"; exit 1; }

  # Check for a project-specific pre-build script and run it if it exists
  PREBUILD_SCRIPT="$SCRIPT_DIR/build-consumers-prebuild-${REPO,,}.sh"  # Absolute path to prebuild script
  echo "DEBUG: Looking for pre-build script at $PREBUILD_SCRIPT"
  if [ -f "$PREBUILD_SCRIPT" ]; then
    echo "Running pre-build script for $REPO..."
    bash "$PREBUILD_SCRIPT" || { echo "Error: pre-build script failed for $REPO"; exit 1; }
  else
    echo "No pre-build script found for $REPO."
  fi

  # Run the prepare and build scripts if they exist
  if [ -f "prepare.sh" ]; then
    echo "Running prepare.sh for $REPO..."
    bash prepare.sh || { echo "Error: prepare.sh failed for $REPO"; exit 1; }
  fi
  
  # Run the install scripts if they exist
  if [ -f "install.sh" ]; then
    echo "Running install.sh for $REPO..."
    bash install.sh || { echo "Error: install.sh failed for $REPO"; exit 1; }
  fi


  if [ -f "build.sh" ]; then
    echo "Running build.sh for $REPO..."
    bash build.sh || { echo "Error: build.sh failed for $REPO"; exit 1; }
  fi

  # Return to the main temporary directory
  cd "$TMP_DIR" || exit 1
  echo "$REPO built successfully."
done

echo "All consumers have been prepared and built successfully."
