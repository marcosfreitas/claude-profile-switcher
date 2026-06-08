function cc-profile --description 'Manage Claude Code profiles'
    set -l profile_file ".claude-profile"

    switch "$argv[1]"
        case "local"
            if set -q argv[2]
                echo $argv[2] > $profile_file
                echo "Pinned local profile to: $argv[2]"
            else
                echo "Usage: cc-profile local <profile_name>"
            end
        
        case "add"
            if set -q argv[2]
                set -l new_dir "$HOME/.claude-$argv[2]"
                if not test -d "$new_dir"
                    mkdir -p "$new_dir"
                    echo "Created new profile directory: $new_dir"
                    echo "Run 'CLAUDE_CONFIG_DIR=$new_dir claude auth login' to authenticate."
                else
                    echo "Profile '$argv[2]' already exists."
                end
            else
                echo "Usage: cc-profile add <profile_name>"
            end

        case "*"
            # Default to fzf selector if no args
            set -l profiles (ls -d $HOME/.claude* | grep -v "\.json\$" | sed "s|$HOME/.claude-||" | sed "s|$HOME/.claude|default|")
            set -l selected (echo "$profiles" | fzf --prompt="Select Claude Profile > " --height=10%)
            
            if test -n "$selected"
                if test "$selected" = "default"
                    set -e CLAUDE_CONTEXT_OVERRIDE
                    echo "Switched to default profile."
                else
                    set -gx CLAUDE_CONTEXT_OVERRIDE "$selected"
                    echo "Switched session to profile: $selected"
                end
            end
    end
end
