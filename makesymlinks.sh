#!/bin/bash
set -e
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
files="bashrc zshrc tmux.conf oh-my-zsh"    # list of files/folders to symlink in homedir

##########

# create dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p "$olddir"
echo "done"

# change to the dotfiles directory
echo -n "Changing to the $dir directory ..."
cd "$dir"
echo "done"

install_zsh () {
# Test to see if zshell is installed.  If it is:
if [ -f /bin/zsh -o -f /usr/bin/zsh ]; then
    # Clone my oh-my-zsh repository from GitHub only if it isn't already present
    if [[ ! -d $dir/oh-my-zsh/ ]]; then
        git clone https://github.com/ohmyzsh/ohmyzsh.git "$dir/oh-my-zsh"
    fi
    # Set the default shell to zsh if it isn't currently set to zsh
    if [[ ! $(echo $SHELL) == $(which zsh) ]]; then
        chsh -s $(which zsh)
    fi
else
    # If zsh isn't installed, get the platform of the current machine
    platform=$(uname);
    # If the platform is Linux, try an apt-get to install zsh and then recurse
    if [[ $platform == 'Linux' ]]; then
        if [[ -f /etc/redhat-release ]]; then
            sudo dnf install -y zsh
            install_zsh
        fi
        if [[ -f /etc/debian_version ]]; then
            sudo apt-get install -y zsh
            install_zsh
        fi
    # If the platform is OS X, tell the user to install zsh :)
    elif [[ $platform == 'Darwin' ]]; then
        echo "Please install zsh, then re-run this script!"
        exit
    fi
fi
}

install_zsh

# Install base packages
sudo apt-get update
sudo apt-get install -y \
    curl \
    htop \
    lsof \
    ssh \
    tmux \
    unzip

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
for file in $files; do
    if [ ! -e "$dir/$file" ] && [ ! -d "$dir/$file" ]; then
        echo "Skipping $file — not found in $dir"
        continue
    fi
    if [ -e ~/.$file ] && [ ! -L ~/.$file ]; then
        echo "Moving existing dotfile ~/.$file to $olddir"
        mv ~/.$file "$olddir/"
    fi
    echo "Creating symlink to $file in home directory."
    ln -sf "$dir/$file" ~/.$file
done

# Install Starship prompt
"$dir/setup-scripts/install_starship.sh"

# Install Google Cloud SDK
"$dir/setup-scripts/install_gcp.sh"

# Install uv
"$dir/setup-scripts/install_uv.sh"

# Install VS Code
"$dir/setup-scripts/install_vscode.sh"

# Install AWS CLI
"$dir/setup-scripts/install_aws.sh"

# Install GitHub CLI
"$dir/setup-scripts/install_github_cli.sh"

# Install Docker
"$dir/setup-scripts/install_docker.sh"
