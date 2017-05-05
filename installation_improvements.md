# What went wrong with an automated installation?

- Vundle didn't install
  - git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  - after this command is sent, then it all works. 
- Need to manually set up and configure git
  - Need to change default shell to zsh
- Need to change terminal background default to solarized
  - Need to sort out a tmux config so that my vim and tmux movement commands are the same
- install chrome
  - wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  - sudo dpkg –i google-chrome-stable_current_amd64.deb
- install docker
  - many steps
    - sudo apt-get install \
        apt-transport-https \
            ca-certificates \
                curl \
                    software-properties-common
    - curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    - sudo add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
          $(lsb_release -cs) \
             stable"
    - sudo apt-get update
    - sudo apt-get install docker-ce
    - sudo groupadd docker
    - sudo usermod -aG docker $USER
- install spotify
  - sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886
  - echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
  - sudo apt-get update
  - sudo apt-get install spotify-client
