# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/home/linuxbrew/.linuxbrew/bin/hugo

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
alias ei3='vim ~/.config/i3/config'
alias ei3b='vim ~/.config/i3/i3blocks.conf'
alias szsh='exec zsh'
alias j=jump

# bat
alias bat=batcat

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

# commands
alias c=clear
alias wally="/usr/local/bin/wally"

function zsh_load_time_plugins() {
    for plugin ($plugins); do
          timer=$(($(gdate +%s%N)/1000000))
          if [ -f $ZSH_CUSTOM/plugins/$plugin/$plugin.plugin.zsh ]; then
            source $ZSH_CUSTOM/plugins/$plugin/$plugin.plugin.zsh
          elif [ -f $ZSH/plugins/$plugin/$plugin.plugin.zsh ]; then
            source $ZSH/plugins/$plugin/$plugin.plugin.zsh
          fi
          now=$(($(gdate +%s%N)/1000000))
          elapsed=$(($now-$timer))
          echo $elapsed":" $plugin
        done
}

time_zsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}
source /home/linuxbrew/.linuxbrew/opt/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
