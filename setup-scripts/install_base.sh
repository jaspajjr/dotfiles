install_base() {
  echo "Installing stuff"
  apt-get update
  apt-get -y upgrade

  apt-get install -y \
		adduser \
		alsa-utils \
		apparmor \
        apt-transport-https \
        curl \
        gcc \
        htop \
        lsof \
        openvpn \
        openconnect \
        ssh \
        tmux
}

main() {
  install_base
}

main
