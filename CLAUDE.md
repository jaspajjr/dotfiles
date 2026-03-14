# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Purpose

This is a personal dotfiles repository for setting up a Linux development machine. It manages shell configuration and installation scripts for common tools.

## Installation

```bash
# Clone to ~/dotfiles (required path)
git clone <repo> ~/dotfiles

# Create symlinks, install zsh, base packages, and all tools (run from repo root)
./makesymlinks.sh
```

`makesymlinks.sh` backs up existing dotfiles to `~/dotfiles_old/` before creating symlinks. It also installs zsh, sets it as the default shell, installs base apt packages, and runs all setup scripts.

## Structure

- **`makesymlinks.sh`** — Full setup entry point: symlinks, zsh, base packages, and all tools
- **`setup-scripts/`** — Modular install scripts called by `makesymlinks.sh`:
  - `install_gcp.sh` — Google Cloud SDK
  - `install_starship.sh` — Starship prompt
  - `install_uv.sh` — uv Python package manager
  - `install_vscode.sh` — Visual Studio Code
- **`oh-my-zsh/`** — Gitignored; managed separately

## Key Configuration Details

**zshrc**: Uses oh-my-zsh with `darkblood` theme. Plugins: `git ubuntu python pip sudo kubectl bundler web-search docker terraform`. Sources `~/.private` for secrets. NVM and GCP SDK paths sourced if present.

**Symlinked files**: `bashrc`, `zshrc`, `oh-my-zsh/`. Sensitive config goes in `~/private` (gitignored).
