#!/bin/bash
set -x
set -e

install_neovim_python() {
    sudo apt-get install python-neovim
}

main() {
    install_neovim_python
}

main