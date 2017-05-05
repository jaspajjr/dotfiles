#!/bin/bash
set -e

## I'm going to hope that this will be a script that installs everything. 

mkdir -p ~/working/github
mkdir -p ~/working/local

setup_sources() {
    cat <<-EOF > /etc/apt/sources.list
    deb http://ppa.launchpad.net/neovim-ppa/unstable/ubuntu trusty main
    deb-src http://ppa.launchpad.net/neovim-ppa/unstable/ubuntu trusty main
    EOF
    
    cat <<-EOF > /etc/apt/sources.list.d/docker.list
    deb https://apt.dockerproject.org/repo debian-stretch main
    deb https://apt.dockerproject.org/repo debian-stretch testing
    deb https://apt.dockerproject.org/repo debian-stretch experimental
    EOF

    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list

    curl https://dl.google.com/linux/linux_signing_key.pub | apt-key add -

    apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
    apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 9DBB0BE9366964F134855E2255F96FCF8231B6DD

    # turn off translations, speed up apt-get update
    mkdir -p /etc/apt/apt.conf.d
    echo 'Acquire::Languages "none";' > /etc/apt/apt.conf.d/99translations
}

install_basic_packages() {
  apt-get update
  apt-get install -y htop && \
    apt-get install -y curl && \
    apt-get install -y git && \
    apt-get install -y ssh && \
    apt-get install -y tmux && \
    apt-get install -y zsh && \
    apt-get install -y xclip
}

main() {
	install_basic_packages
	setup_sources
}
