# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
ZSH_THEME=""  # Prompt handled by Starship

COMPLETION_WAITING_DOTS="true"

plugins=(git python pip sudo kubectl docker terraform gcloud aws)

source $ZSH/oh-my-zsh.sh

# Put any proprietary or private functions/values in ~/.private, and this will source them
if [ -f $HOME/.private ]; then
  source $HOME/.private
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

## Miscellaneous Aliases
alias htop='sudo htop'
alias ls='ls -l'

# Shell Functions
# qfind - used to quickly find files that contain a string in a directory
qfind () {
  find . -exec grep -l -s $1 {} \;
  return 0
}



[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"

# Starship prompt
eval "$(starship init zsh)"
