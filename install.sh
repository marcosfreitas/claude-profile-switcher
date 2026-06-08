#!/usr/bin/env bash

# install.sh - Installer for Claude Profile Switcher

set -e

INSTALL_DIR="$HOME/.local/share/claude-profile-switcher"
FISH_FUNC_DIR="$HOME/.config/fish/functions"

echo "Installing Claude Profile Switcher..."

# 1. Create directory structure
mkdir -p "$INSTALL_DIR/bin"
mkdir -p "$INSTALL_DIR/functions"

# 2. Copy files
cp bin/claude-profile-switcher-core.sh "$INSTALL_DIR/bin/"
cp functions/*.fish "$INSTALL_DIR/functions/"
chmod +x "$INSTALL_DIR/bin/claude-profile-switcher-core.sh"

# 3. Install Fish functions if directory exists
if [ -d "$FISH_FUNC_DIR" ]; then
    echo "Installing Fish functions to $FISH_FUNC_DIR..."
    cp functions/*.fish "$FISH_FUNC_DIR/"
    
    # Update the local claude.fish to point to the installed core script
    # We use a temp file to avoid issues with sed in-place
    sed "s|set -l core_script.*|set -l core_script $INSTALL_DIR/bin/claude-profile-switcher-core.sh|" "$FISH_FUNC_DIR/claude.fish" > "$FISH_FUNC_DIR/claude.fish.tmp"
    mv "$FISH_FUNC_DIR/claude.fish.tmp" "$FISH_FUNC_DIR/claude.fish"
fi

echo "Successfully installed to $INSTALL_DIR"
echo "You may need to restart your shell or run 'source ~/.config/fish/config.fish'"
