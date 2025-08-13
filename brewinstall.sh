#!/bin/bash

# Ensure Homebrew is installed
if ! command -v brew &>/dev/null; then
  echo "Homebrew not found. Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Make sure brew is up to date
echo "Updating Homebrew..."
brew update

# Install packages from Brewfile
echo "Installing from Brewfile..."
brew bundle --file="$(dirname "$0")/Brewfile"

