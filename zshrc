# Explicitly configured $PATH variable
PATH=/usr/local/git/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/opt/local/bin:/opt/local/sbin:/usr/X11/bin

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
ZSH_THEME="darkblood"

# Sources autocomplete for azure cli
source /etc/bash_completion.d/azure-cli

COMPLETION_WAITING_DOTS="true"

plugins=(git ubuntu python pip sudo kubectl bundler web-search docker terraform)

source $ZSH/oh-my-zsh.sh

# Put any proprietary or private functions/values in ~/.private, and this will source them
if [ -f $HOME/.private ]; then
  source $HOME/.private
fi

if [ -f $HOME/.profile ]; then
  source $HOME/.profile  # Read Mac .profile, if present.
fi

if [ $commands[kubectl] ]; then
  source <(kubectl completion zsh)
fi

# Shell Aliases
## Git Aliases
alias gs='git status '
alias ga='git add '
alias gb='git branch '
alias gc='git commit'
alias gd='git diff'
alias go='git checkout '
alias gk='gitk --all&'
alias gx='gitx --all'
alias got='git '
alias get='git '
alias db='docker build '
alias dr='docker run '

## Vagrant Aliases
alias vag='vagrant'
alias vagup='vagrant up'
alias vagdestroy='vagrant destroy'
alias vagssh='vagrant ssh'
alias vaghalt='vagrant halt'

## Miscellaneous Aliases
alias htop='sudo htop'
alias ls='ls -l'

# Shell Functions
# qfind - used to quickly find files that contain a string in a directory
qfind () {
  find . -exec grep -l -s $1 {} \;
  return 0
}

## Open vim in container
alias editor='docker run -ti --rm -v $(pwd):/home/developer/workspace jaspajjr/alpine-vim'
## Setting ENV variables
LD_LIBRARY_PATH='/usr/local/bin'

# Custom exports
## Set EDITOR to /usr/bin/vim if Vim is installed
if [ -f /usr/bin/vim ]; then
  export EDITOR=/usr/bin/vim
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/jasper/working/gcp-continuous-deployment-example/google-cloud-sdk/path.zsh.inc' ]; then . '/home/jasper/working/gcp-continuous-deployment-example/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/jasper/working/gcp-continuous-deployment-example/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/jasper/working/gcp-continuous-deployment-example/google-cloud-sdk/completion.zsh.inc'; fi
