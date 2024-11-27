#!/bin/bash

echo "Preparing dependencies for DisplayValueLCD..."

# Path to dependencies.txt
DEPENDENCIES_FILE="./dependencies.txt"
PARENT_DIR=$(dirname "$(pwd)")

# Ensure dependencies.txt exists
if [ ! -f "${DEPENDENCIES_FILE}" ]; then
  echo "Error: dependencies.txt not found."
  exit 1
fi

# Read dependencies and process each one
while IFS=',' read -r DEP_NAME GIT_URL || [ -n "$DEP_NAME" ]; do
  # Trim spaces and handle carriage returns
  DEP_NAME=$(echo "${DEP_NAME}" | tr -d '\r' | sed 's/^[ \t]*//;s/[ \t]*$//')
  GIT_URL=$(echo "${GIT_URL}" | tr -d '\r' | sed 's/^[ \t]*//;s/[ \t]*$//')

  # Skip empty lines
  if [[ -z "$DEP_NAME" || -z "$GIT_URL" ]]; then
    echo "Skipping empty or invalid line"
    continue
  fi

  echo "Processing dependency: DEP_NAME=${DEP_NAME}, GIT_URL=${GIT_URL}"

  DEP_PATH="${PARENT_DIR}/${DEP_NAME}"

  if [ ! -d "${DEP_PATH}" ]; then
    echo "Cloning ${DEP_NAME} into ${PARENT_DIR}..."
    git clone "${GIT_URL}" "${DEP_PATH}" || {
      echo "Error: Failed to clone ${DEP_NAME}. Skipping."
      continue
    }
  else
    echo "Updating ${DEP_NAME}..."
    git -C "${DEP_PATH}" pull || {
      echo "Error: Failed to update ${DEP_NAME}. Skipping."
      continue
    }
  fi

  # Run the dependency's prepare.sh if it exists
  if [ -f "${DEP_PATH}/prepare.sh" ]; then
    echo "Running prepare.sh for ${DEP_NAME}..."
    bash "${DEP_PATH}/prepare.sh" || {
      echo "Error: Failed to prepare ${DEP_NAME}. Skipping."
      continue
    }
  else
    echo "No prepare.sh found for ${DEP_NAME}. Skipping preparation."
  fi
done < "${DEPENDENCIES_FILE}"

echo "Dependencies for DisplayValueLCD prepared successfully."