# Claude Profile Switcher

A terminal-agnostic profile switcher for Claude Code.

## Features
- **Project-based Switching**: Automatically switch Claude accounts based on the `.claude-profile` file in your project.
- **Session Overrides**: Manually switch profiles for the current terminal session.
- **Terminal Agnostic**: Core logic is written in Bash, with specialized integrations for Fish (and more coming).
- **Interactive UI**: Switch profiles using `fzf`.

## Installation

### Fish
1. Clone this repository to a location of your choice (e.g., `~/Projects/claude-profile-switcher`).
2. Copy the functions to your fish config:
   ```bash
   cp functions/*.fish ~/.config/fish/functions/
   ```
3. Ensure the core script is executable:
   ```bash
   chmod +x bin/claude-profile-switcher-core.sh
   ```
4. (Optional) Add the `bin` directory to your `$PATH` or update the path in `functions/claude.fish` to point to the absolute location of `claude-profile-switcher-core.sh`.

## Usage
- `cc-profile`: Interactive picker to switch profiles.
- `cc-profile local <name>`: Pin a specific profile to the current directory.
- `cc-profile add <name>`: Create a new isolated profile.

## License
This project is licensed under the **Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0)**. 
Credits to **Marcos Freitas**.
