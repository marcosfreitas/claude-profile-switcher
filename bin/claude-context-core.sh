#!/usr/bin/env bash

# claude-context-core.sh
# Core logic for determining the Claude configuration directory

get_claude_config_dir() {
    local current_dir="$PWD"
    local profile_file=".claude-profile"
    
    # 1. Check for manual override in environment
    if [[ -n "$CLAUDE_CONTEXT_OVERRIDE" ]]; then
        echo "$HOME/.claude-$CLAUDE_CONTEXT_OVERRIDE"
        return
    fi

    # 2. Traverse up to find .claude-profile
    while [[ "$current_dir" != "/" ]]; do
        if [[ -f "$current_dir/$profile_file" ]]; then
            local profile_name
            profile_name=$(cat "$current_dir/$profile_file" | tr -d '[:space:]')
            if [[ -n "$profile_name" ]]; then
                echo "$HOME/.claude-$profile_name"
                return
            fi
        fi
        current_dir=$(dirname "$current_dir")
    done

    # 3. Default to standard ~/.claude
    echo "$HOME/.claude"
}

# If called directly, output the path
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    get_claude_config_dir
fi
