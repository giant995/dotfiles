# commands
alias c=clear
# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="agnoster"

plugins=(
	git
	jump
	sudo
	python
)

source $ZSH/oh-my-zsh.sh

export EDITOR='vim'

# Locale
export LANGUAGE="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# git
alias 'committed'='git log origin..HEAD'

# npm
export PATH=~/.npm-global/bin:$PATH
alias 'npmbs'='npm run build && npm run start'

# ls whenever the dir change 
function chpwd() {
  ls
}

# ZSH
alias ezsh='vim ~/.zshrc'
alias szsh='source ~/.zshrc'
alias j=jump

# Docker
function  tlm.get_container_id_that_contains() {
 container_name=$1
 container_infos=`docker ps -a | grep $container_name`
 echo $container_infos | awk '{print $1}'
}
alias 'dcu'='docker-compose up --build'

# The fuck
eval $(thefuck --alias)

# xclip
#alias iclip='xclip -selection clipboard'
#alias oclip='xclip -selection clipboard -o'

# File explorer
# Open current dir in file manager
alias oie='xdg-open .'
odie() {
  if [ "$1" != "" ]
  then
    xdg-open "$1"
  else
    oie
  fi
}

# misc
alias 'gnite'='sudo poweroff'

export NVM_DIR="/home/jm/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# dotfiles git config
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# tmuxinator
alias mux="tmuxinator"

# Enable vi editing mode
bindkey -v
bindkey "^R" history-incremental-search-backward
source ~/.oh-my-zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# i3
alias settings='env XDG_CURRENT_DESKTOP=GNOME gnome-control-center'
