#! /bin/bash
set -x
set -e

export DEBIAN_FRONTEND=noninteractive

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

install_docker() {

  # create docker group
  sudo groupadd docker
  sudo gpasswd -a "$TARGET_USER" docker
  
  curl -sSL https://get.docker.com/builds/Linux/x86_64/docker-latest.tgz | tar -xvz \
  	-C /usr/local/bin --strip-components 1
  
  chmod +x /usr/local/bin/docker*

}

main() {
    get_user
    install_docker
}

main