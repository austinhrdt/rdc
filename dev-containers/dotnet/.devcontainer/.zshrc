# set your path
export PATH=$HOME/.local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# 256 colors
export TERM="xterm-256color"

# set your theme
ZSH_THEME="powerlevel9k/powerlevel9k"

POWERLEVEL9k_MODE="nerdfont-complete"

POWERLEVEL9K_AWS_ICON=''

# os icon styles
POWERLEVEL9K_LINUX_UBUNTU_ICON='\uf31b '
POWERLEVEL9K_OS_ICON_BACKGROUND='grey'

# git styles
POWERLEVEL9K_VCS_GIT_ICON='  \ue709 '
POWERLEVEL9K_VCS_BRANCH_ICON=' \ue0a0'

# customize theme
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir_writable dir vcs virtualenv)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(history)

POWERLEVEL9K_PYTHON_ICON='\ue73c'
POWERLEVEL9K_VIRTUALENV_FOREGROUND='196'
POWERLEVEL9K_VIRTUALENV_BACKGROUND='239'

# lock icon
POWERLEVEL9K_LOCK_ICON='\uf023'

# customize directory path symbols
POWERLEVEL9K_LEFT_SEGMENT_END_SEPARATOR='  '
POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR='\ue0bc'
POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR='\ue0bd'
POWERLEVEL9K_DIR_PATH_SEPARATOR=" "$'\ue0bb'"  "

# set up python virtual environment settings
export WORKON_HOME=~/.envs
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
export VIRTUALENVWRAPPER_SCRIPT=/home/Austin/.local/bin/virtualenvwrapper.sh
source $HOME/.local/bin/virtualenvwrapper.sh

export PIP_REQUIRE_VIRTUALENV=true

# set your plugins
plugins=(git zsh-autosuggestions thefuck)

source $ZSH/oh-my-zsh.sh


# CUSTOM USER SETTINGS

# allow global pip commands using gpip
gpip() {
  PIP_REQUIRE_VIRTUALENV="" pip3 "$@"
}

# [shift + q] autoaccept suggestion
bindkey 'Q' autosuggest-accept

# [shift + 1] auto execute
bindkey '!' autosuggest-execute


# git remote add origin from git enterprise
connect () {
  export url='https://'$GITHUB_TOKEN'@github.com/'$GITHUB_USER'/'$1'.git'
  git remote add origin $url
  unset url
}

# clone repo from git enterprise
clone () {
  export url='https://'$GITHUB_TOKEN'@github.com/'$GITHUB_USER'/'$1'.git'
  git clone $url
  unset url
}

# creates a repo on github.com
create-repo() {
  curl -H "Authorization: token $GITHUB_TOKEN" --data '{"name":"'$1'"}' https://api.github.com/user/repos
}

# deletes a repo on github.com
delete-repo() {
  curl -X DELETE -u $GITHUB_USER:$GITHUB_TOKEN https://api.github.com/repos/$GITHUB_USER/$1
}

# clones all of the users repositories
clone-all() {
  curl -H "Authorization: token $GITHUB_TOKEN" https://api.github.com/users/$GITHUB_USER/repos | \
  grep -w '"name":' | sed 's/.*://' | rev | cut -c 2- | rev | \
  xargs -L1 -I '$' git clone https://$GITHUB_TOKEN@github.com/$GITHUB_USER/$.git
}

# install homebrew, only have to do this once
# sudo chmod 777 /var/run/docker.sock
initialize() {
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
  echo 'eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)' >>~/.profile
  eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
  brew update && brew upgrade && brew cleanup; brew doctor
  brew install gcc kubernetes-helm
}

# deploy docker app (args: name and port)
deploy() {
  docker build -t ${PWD##*/} .
  docker run -d -p $2:$2 --name $1 ${PWD##*/}
}

# aliases
alias refresh="clear && source ~/.zshrc"
alias gs="git status"
alias zshconfig="code ~/.zshrc"
alias pip="pip3"
alias python="python3"
alias devenv="cd /workspaces/rdc/dev-containers"
alias gacp="git add . && git commit -m 'automated commit' && git push origin master"
alias work="cd ~/working"
alias brewski='brew update && brew upgrade && brew cleanup; brew doctor'
alias code='code-insiders'