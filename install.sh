#!/bin/bash
set -e

# I'm going to hope that this will be a script that installs everything. 
USERNAME = $(find /home/* -maxdepth 0 -printf "%f" -type d ||   echo "$USER")
export DEBIAN_FRONTEND=noninteractive

check_is_sudo() {
  if [ "$EUID" -ne 0 ]; then
    echo "Please run as root."
    exit
  fi
}

# TODO: need to do the actual basics from jessfraz/dotfiles/bin/install.sh
# setup docker
# - decide whether or no I should run data science, pandas etc through docker or install
# it onto the system
# - install all of the python libraries that I would need to use for dev stuff
# - install deadsnakes etc
# - install R, Rstudio
# - install Rust
# - install the basic requirements for pandas and sklearn etc, LIBLAPACK, BLAS etc
# 
