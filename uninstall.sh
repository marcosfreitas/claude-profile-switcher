#!/usr/bin/env bash

# uninstall.sh - Uninstaller for Claude Profile Switcher

INSTALL_DIR="$HOME/.local/share/claude-profile-switcher"
FISH_FUNC_DIR="$HOME/.config/fish/functions"

echo "Uninstalling Claude Profile Switcher..."

# 1. Remove the main installation directory
if [ -d "$INSTALL_DIR" ]; then
    rm -rf "$INSTALL_DIR"
    echo "Removed $INSTALL_DIR"
fi

# 2. Remove Fish functions
if [ -d "$FISH_FUNC_DIR" ]; then
    rm -f "$FISH_FUNC_DIR/claude.fish"
    rm -f "$FISH_FUNC_DIR/cc-profile.fish"
    echo "Removed Fish functions from $FISH_FUNC_DIR"
fi

echo "Uninstallation complete."
