function claude --description 'Context-aware Claude Code wrapper'
    # Use a relative path or an environment variable to locate the core script
    # For a standard installation, we expect it to be in the path or a known relative location
    set -l core_script (status dirname)/../bin/claude-context-core.sh
    
    if test -f "$core_script"
        set -l config_dir (bash "$core_script")
        
        if test "$config_dir" != "$HOME/.claude"
            set -x CLAUDE_CONFIG_DIR $config_dir
        end
    end

    command claude $argv
end
