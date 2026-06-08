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

        case "clone"
            set -l src_name
            set -l target_name $argv[2]

            # If no target name provided, ask for it
            if not set -q argv[2]
                read -P "Enter name for new profile: " target_name
            end

            if test -z "$target_name"
                echo "Error: Target profile name cannot be empty."
                return 1
            end

            # Select source profile interactively
            set -l profiles (ls -d $HOME/.claude* | grep -v "\.json\$" | sed "s|$HOME/.claude-||" | sed "s|$HOME/.claude|default|")
            set src_name (echo "$profiles" | fzf --prompt="Select Source Profile to Clone > " --height=10%)

            if test -z "$src_name"
                echo "Clone cancelled."
                return 0
            end
                
            set -l src_dir "$HOME/.claude"
            if test "$src_name" != "default"
                set src_dir "$HOME/.claude-$src_name"
            end
            
            set -l target_dir "$HOME/.claude-$target_name"
            
            if not test -d "$src_dir"
                echo "Error: Source profile '$src_name' does not exist at $src_dir"
                return 1
            end
            
            if test -d "$target_dir"
                echo "Error: Target profile '$target_name' already exists."
                return 1
            end
            
            mkdir -p "$target_dir"
            echo "Cloning profile '$src_name' to '$target_name'..."
            
            # Selective copying
            for item in settings.json skills plugins hooks
                if test -e "$src_dir/$item"
                    cp -r "$src_dir/$item" "$target_dir/"
                    echo "  [✓] Copied $item"
                end
            end
            
            echo "Profile '$target_name' created. Credentials and history were NOT copied."
            echo "Run 'CLAUDE_CONFIG_DIR=$target_dir claude auth login' to authenticate."

        case "*"
            # Filter for actual configuration directories only
            set -l profiles (for d in $HOME/.claude*/; 
                # Skip the local pin file and non-directories
                if test -d "$d" -a (basename "$d") != ".claude-profile"
                    echo "$d" | sed "s|$HOME/.claude-||" | sed "s|$HOME/.claude/|default|" | sed "s|/||"
                end
            end | sort -u)

            set -l selected (echo "$profiles" | fzf --prompt="Select Claude Profile > " \
                --height=15% --reverse --border --header="Current: $CLAUDE_CONTEXT_OVERRIDE")
            
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
