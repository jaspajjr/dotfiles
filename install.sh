#!/bin/bash
set -e

# expects things to be automated
export DEBIAN_FRONTEND=noninteractive

mkdir -p ~/working/github
mkdir -p ~/working/local

# Choose a user account to use for this installation
get_user() {
    if [ -z "${TARGET_USER-}" ]; then
       PS3='Which user account should be used? '
       options=($(find /home/* -maxdepth 0 -printf "%f\n" -type d))
       select opt in "${options[@]}"; do
           readonly TARGET_USER=$opt
           break
       done
    fi
}


setup_sources() {
	cat <<-EOF > /etc/apt/sources.list
	deb http://httpredir.debian.org/debian stretch main contrib non-free
	deb-src http://httpredir.debian.org/debian/ stretch main contrib non-free

	deb http://httpredir.debian.org/debian/ stretch-updates main contrib non-free
	deb-src http://httpredir.debian.org/debian/ stretch-updates main contrib non-free

	deb http://security.debian.org/ stretch/updates main contrib non-free
	deb-src http://security.debian.org/ stretch/updates main contrib non-free

	#deb http://httpredir.debian.org/debian/ jessie-backports main contrib non-free
	#deb-src http://httpredir.debian.org/debian/ jessie-backports main contrib non-free

	deb http://httpredir.debian.org/debian experimental main contrib non-free
	deb-src http://httpredir.debian.org/debian experimental main contrib non-free

	# hack for latest git (don't judge)
	deb http://ppa.launchpad.net/git-core/ppa/ubuntu xenial main
	deb-src http://ppa.launchpad.net/git-core/ppa/ubuntu xenial main

	# neovim
	deb http://ppa.launchpad.net/neovim-ppa/unstable/ubuntu xenial main
	deb-src http://ppa.launchpad.net/neovim-ppa/unstable/ubuntu xenial main

	# yubico
	deb http://ppa.launchpad.net/yubico/stable/ubuntu xenial main
	deb-src http://ppa.launchpad.net/yubico/stable/ubuntu xenial main

	# tlp: Advanced Linux Power Management
	# http://linrunner.de/en/tlp/docs/tlp-linux-advanced-power-management.html
	deb http://repo.linrunner.de/debian sid main
	EOF

	# add docker apt repo
	cat <<-EOF > /etc/apt/sources.list.d/docker.list
	deb https://apt.dockerproject.org/repo debian-stretch main
	deb https://apt.dockerproject.org/repo debian-stretch testing
	deb https://apt.dockerproject.org/repo debian-stretch experimental
	EOF

    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list

	# Import the Google Chrome public key
    curl https://dl.google.com/linux/linux_signing_key.pub | apt-key add -

	# add docker gpg key
	apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

	# add the neovim ppa gpg key
    apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 9DBB0BE9366964F134855E2255F96FCF8231B6DD

    # turn off translations, speed up apt-get update
    mkdir -p /etc/apt/apt.conf.d
    echo 'Acquire::Languages "none";' > /etc/apt/apt.conf.d/99translations
}

install_docker() {
	# create docker group
	sudo groupadd docker
	sudo gpasswd -a "$TARGET_USER" docker


	curl -sSL https://get.docker.com/builds/Linux/x86_64/docker-latest.tgz | tar -xvz \
		-C /usr/local/bin --strip-components 1
	chmod +x /usr/local/bin/docker*

	curl -sSL https://raw.githubusercontent.com/jessfraz/dotfiles/master/etc/systemd/system/docker.service > /etc/systemd/system/docker.service
	curl -sSL https://raw.githubusercontent.com/jessfraz/dotfiles/master/etc/systemd/system/docker.socket > /etc/systemd/system/docker.socket

	systemctl daemon-reload
	systemctl enable docker

	# update grub with docker configs and power-saving items
	sed -i.bak 's/GRUB_CMDLINE_LINUX=""/GRUB_CMDLINE_LINUX="cgroup_enable=memory swapaccount=1 pcie_aspm=force apparmor=1 security=apparmor"/g' /etc/default/grub
	echo "Docker has been installed. If you want memory management & swap"
	echo "run update-grub & reboot"
}


# installs the basic stuff that I would want on any install.
base() {
  apt-get update
  apt-get -y upgrade

  apt-get install -y \
		adduser \ 
		alsa-utils \ 
		apparmor \ 
        curl \
        gcc \
        lsof \
        openvpn \
        openconnect \
        ssh \

    # python stuff
  apt-get update

  apt-get install -y \
    python-dev \
    python-pip \

	sudo apt-get install -y \
		python3-pip \
		--no-install-recommends

	pip3 install -U \
		setuptools \
		wheel \
		neovim


    setup_sudo
    apt-get autoremove
	apt-get autoclean
	apt-get clean

    install_docker
    install_vim;

}

install_vim() {
	# create subshell
	(
	cd "$HOME"

	# install .vim files
	git clone --recursive git@github.com:jessfraz/.vim.git "${HOME}/.vim"
	ln -snf "${HOME}/.vim/vimrc" "${HOME}/.vimrc"
	sudo ln -snf "${HOME}/.vim" /root/.vim
	sudo ln -snf "${HOME}/.vimrc" /root/.vimrc

	# alias vim dotfiles to neovim
	mkdir -p "${XDG_CONFIG_HOME:=$HOME/.config}"
	ln -snf "${HOME}/.vim" "${XDG_CONFIG_HOME}/nvim"
	ln -snf "${HOME}/.vimrc" "${XDG_CONFIG_HOME}/nvim/init.vim"
	# do the same for root
	sudo mkdir -p /root/.config
	sudo ln -snf "${HOME}/.vim" /root/.config/nvim
	sudo ln -snf "${HOME}/.vimrc" /root/.config/nvim/init.vim

	# update alternatives to neovim
	sudo update-alternatives --install /usr/bin/vi vi "$(which nvim)" 60
	sudo update-alternatives --config vi
	sudo update-alternatives --install /usr/bin/vim vim "$(which nvim)" 60
	sudo update-alternatives --config vim
	sudo update-alternatives --install /usr/bin/editor editor "$(which nvim)" 60
	sudo update-alternatives --config editor

	# install things needed for deoplete for vim
	sudo apt-get update

	sudo apt-get install -y \
		python3-pip \
		--no-install-recommends

	pip3 install -U \
		setuptools \
		wheel \
		neovim
	)
}

install_docker() {

  # create docker group
  sudo groupadd docker
  sudo gpasswd -a "$TARGET_USER" docker
  
  curl -sSL https://get.docker.com/builds/Linux/x86_64/docker-latest.tgz | tar -xvz \
  	-C /usr/local/bin --strip-components 1
  
  chmod +x /usr/local/bin/docker*

}

main() {
  install_basic_packages
  setup_sources
  base
}
