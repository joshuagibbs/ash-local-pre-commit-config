#!/bin/bash

# USAGE: ./ash-config.sh [options] <repo-path>
#
# Options:
#   -g, --git-folder <path>   Specify Git folder path (default: ${HOME}/Documents/Git)
#   -v, --verbose             Enable verbose output
#   -h, --help                Display this help message
#
# Example: ./ash-config.sh "${HOME}"/Documents/Git/<REPO_NAME>

set -e

# Default values
GIT_FOLDER="${HOME}/Documents/Git"
VERBOSE=false
SHOW_HELP=false

# Parse command line arguments
while [[ $# -gt 0 ]]; do
  case "$1" in
    -g|--git-folder)
      GIT_FOLDER="$2"
      shift 2
      ;;
    -v|--verbose)
      VERBOSE=true
      shift
      ;;
    -h|--help)
      SHOW_HELP=true
      shift
      ;;
    *)
      DESTINATION_DIR="$1"
      shift
      ;;
  esac
done

# Show help message
if [ "$SHOW_HELP" = true ]; then
  echo "Usage: ./ash-config.sh [options] <repo-path>"
  echo ""
  echo "Options:"
  echo "  -g, --git-folder <path>   Specify Git folder path (default: ${HOME}/Documents/Git)"
  echo "  -v, --verbose             Enable verbose output"
  echo "  -h, --help                Display this help message"
  echo ""
  echo "Example: ./ash-config.sh \"${HOME}\"/Documents/Git/<REPO_NAME>"
  exit 0
fi

# Validate destination directory
if [ -z "${DESTINATION_DIR}" ]; then
  echo "Error: Destination directory not provided when executing script"
  echo "Run './ash-config.sh --help' for usage information"
  exit 1
fi

if [ ! -d "${DESTINATION_DIR}" ]; then
  echo "Error: Destination directory does not exist: ${DESTINATION_DIR}"
  exit 1
fi

if [ ! -w "${DESTINATION_DIR}" ]; then
  echo "Error: Destination directory is not writable: ${DESTINATION_DIR}"
  exit 1
fi

# Check if .git/hooks directory exists
HOOKS_DIR="${DESTINATION_DIR}/.git/hooks"
if [ ! -d "${HOOKS_DIR}" ]; then
  echo "Error: ${DESTINATION_DIR} does not appear to be a git repository (no .git/hooks directory)"
  exit 1
fi

# Check if ASH is installed
ASH_REPO="${GIT_FOLDER}/automated-security-helper"
if [ ! -d "${ASH_REPO}" ]; then
  echo "Warning: AWS Automated Security Helper (ASH) repository not found at ${ASH_REPO}"
  echo "Please clone the ASH repository first:"
  echo "  cd \"${GIT_FOLDER}\""
  echo "  git clone https://github.com/awslabs/automated-security-helper.git"
  echo ""
  read -p "Continue anyway? (y/n): " -n 1 -r
  echo ""
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
  fi
fi

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
  echo "Warning: Docker does not appear to be running"
  echo "ASH requires Docker to function properly"
  echo ""
  read -p "Continue anyway? (y/n): " -n 1 -r
  echo ""
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
  fi
fi

# Backup existing pre-commit hook if it exists
if [ -f "${HOOKS_DIR}/pre-commit" ]; then
  BACKUP_FILE="${HOOKS_DIR}/pre-commit.bak.$(date +%Y%m%d%H%M%S)"
  echo "Backing up existing pre-commit hook to ${BACKUP_FILE}"
  cp "${HOOKS_DIR}/pre-commit" "${BACKUP_FILE}"
fi

echo "Destination directory is ${DESTINATION_DIR}"
echo "Copying pre-commit hook to ${HOOKS_DIR}"

# Copy the pre-commit hook
if cp ./pre-commit "${HOOKS_DIR}/pre-commit"; then
  # Make the pre-commit hook executable
  chmod +x "${HOOKS_DIR}/pre-commit"
  echo "✅ Successfully installed ASH pre-commit hook"
  echo "The hook will run ASH on your code before each commit"
else
  echo "❌ Failed to copy pre-commit hook"
  exit 1
fi
