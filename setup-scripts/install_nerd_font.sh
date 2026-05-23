#!/bin/bash
set -e

# Install JetBrainsMono Nerd Font
FONT_NAME="JetBrainsMono"
FONT_DIR="$HOME/.local/share/fonts/NerdFonts"
VERSION=$(curl -s "https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest" | grep '"tag_name"' | cut -d'"' -f4)

mkdir -p "$FONT_DIR"

curl -fLo "/tmp/${FONT_NAME}.zip" \
    "https://github.com/ryanoasis/nerd-fonts/releases/download/${VERSION}/${FONT_NAME}.zip"

unzip -o "/tmp/${FONT_NAME}.zip" -d "$FONT_DIR"
rm "/tmp/${FONT_NAME}.zip"

fc-cache -fv "$FONT_DIR"
echo "Installed ${FONT_NAME} Nerd Font ${VERSION}"
