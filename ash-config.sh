#!/bin/bash

# USAGE: ./ash-config.sh "${HOME}"/Documents/Git/<REPO_NAME>
set -e

# Set DESTINATION_DIR variable based on path passed in when script is executed.
DESTINATION_DIR=$1

if [ -z "${DESTINATION_DIR}" ]; then
  echo "Destination directory not provided as when executing script"
  exit 1
fi
if [ ! -d "${DESTINATION_DIR}" ]; then
  echo "Destination directory does not exist"
  exit 1
fi
if [ ! -w "${DESTINATION_DIR}" ]; then
  echo "Destination directory is not writable"
  exit 1
fi
echo "Destination directory is ${DESTINATION_DIR}"
echo "Copying pre-commit hook to ${DESTINATION_DIR}"

cp ./pre-commit "${DESTINATION_DIR}"/.git/hooks/pre-commit
