# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Purpose

This is a personal dotfiles repository for setting up a Linux development machine. It manages shell configuration, editor settings, and installation scripts for common tools.

## Installation

```bash
# Clone to ~/dotfiles (required path)
git clone <repo> ~/dotfiles

# Create symlinks and set up zsh (run from repo root)
./makesymlinks.sh

# Full system setup (requires elevated privileges)
sudo ./install.sh
```

`makesymlinks.sh` backs up existing dotfiles to `~/dotfiles_old/` before creating symlinks. It also installs zsh and sets it as the default shell.

## Structure

- **`makesymlinks.sh`** — Creates symlinks from `~/` to dotfiles in this repo; entry point for new machines
- **`install.sh`** — Full system setup: APT sources, Docker, Python, Vundle, etc.
- **`setup-scripts/`** — Modular install scripts sourced by `install.sh`:
  - `install_base.sh` — Core system packages (tmux, curl, ssh, etc.)
  - `install_docker.sh` — Docker binary install + group setup
  - `install_gcp.sh` — Google Cloud SDK, kubectl, minikube
  - `install_python.sh` — Python 2/3 with pip packages
  - `install_vim.sh` — Compiles Vim from source with full feature flags
  - `install_neovim.sh` — Neovim Python support
- **`Makefile`** — Runs `setup_docker` and `setup_python` targets
- **`oh-my-zsh/`** — Gitignored; managed separately
- **`vim/`** — Vim plugins directory (Vundle-managed)

## Key Configuration Details

**zshrc**: Uses oh-my-zsh with `darkblood` theme. Plugins: `git ubuntu python pip sudo kubectl bundler web-search docker terraform`. Sources `~/.private` for secrets. NVM and GCP SDK paths sourced if present.

**vimrc**: Uses Vundle. Notable plugins: YouCompleteMe, jedi-vim, vim-flake8, NERDTree, syntastic. Tab width: 4 spaces (softtabstop: 2). `jk` mapped to Escape.

**Symlinked files**: `bashrc`, `vimrc`, `vim/`, `zshrc`, `oh-my-zsh/`, `scrotwm.conf`, `Xresources`. Sensitive config goes in `~/private` (gitignored).

## Known Issues (from `installation_improvements.md`)

- Vundle must be manually cloned: `git clone https://github.com/VundleVim/Vundle.vim ~/.vim/bundle/Vundle.vim`
- After symlinks, run `:PluginInstall` in Vim manually
- Terminal solarized theme must be set manually in terminal emulator preferences
- Tmux configuration is not automated
