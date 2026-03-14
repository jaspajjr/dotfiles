# dotfiles

Personal dotfiles for setting up a Linux (Ubuntu 24.04) development machine.

## Installation

```bash
git clone <repo> ~/dotfiles
cd ~/dotfiles
./makesymlinks.sh
```

`makesymlinks.sh` will:
1. Back up any existing dotfiles to `~/dotfiles_old/`
2. Create symlinks in `~/` for `bashrc`, `zshrc`, `tmux.conf`, and `oh-my-zsh`
3. Install zsh and set it as the default shell
4. Install base packages: `curl`, `htop`, `lsof`, `ssh`, `tmux`, `unzip`
5. Install Starship prompt
6. Install Google Cloud SDK
7. Install uv (Python package manager)
8. Install VS Code
9. Install AWS CLI
10. Install GitHub CLI

## After running

- Log out and back in for the default shell change to take effect
- Run `gcloud auth login` to authenticate with GCP
- Run `aws configure` to authenticate with AWS
- Run `gh auth login` to authenticate with GitHub

## Structure

```
dotfiles/
├── makesymlinks.sh       # Setup entry point
├── bashrc
├── zshrc
├── tmux.conf
└── setup-scripts/
    ├── install_aws.sh
    ├── install_gcp.sh
    ├── install_github_cli.sh
    ├── install_starship.sh
    ├── install_uv.sh
    └── install_vscode.sh
```

## Sensitive config

Put private environment variables and secrets in `~/.private` — it will be sourced automatically by `zshrc` if present. This file is gitignored.
