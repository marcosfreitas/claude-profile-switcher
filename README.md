# Claude Profile Switcher

A terminal-agnostic profile switcher for Claude Code.

## Features
- **Project-based Switching**: Automatically switch Claude accounts based on the `.claude-profile` file in your project.
- **Session Overrides**: Manually switch profiles for the current terminal session.
- **Terminal Agnostic**: Core logic is written in Bash, with specialized integrations for Fish (and more coming).
- **Interactive UI**: Switch profiles using `fzf`.

## Installation

### Automatic (Linux/macOS)
1. Clone this repository:
   ```bash
   git clone https://github.com/marcosfreitas/claude-profile-switcher.git
   cd claude-profile-switcher
   ```
2. Run the installer:
   ```bash
   ./install.sh
   ```

### Manual
If you prefer to install manually, you can copy the files to `~/.local/share/claude-profile-switcher` and link the functions to your shell configuration directory.

## Usage
- `cc-profile`: Interactive picker to switch profiles.
- `cc-profile local <name>`: Pin a specific profile to the current directory.
- `cc-profile add <name>`: Create a new isolated profile.

## License
This project is licensed under the **Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0)**. 
Credits to **Marcos Freitas**.
