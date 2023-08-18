export PATH="${HOMEBREW_PREFIX}/opt/openssl/bin:$PATH"
export PATH=$HOME/bin:$PATH
export PATH="$PATH:/usr/local/opt/openjdk/bin"
export PATH="$PATH:${HOME}/.docker/bin"
export PATH="$PATH:$(go env GOPATH)/bin"
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

export HOMEBREW_NO_AUTO_UPDATE=1
export CLOUDSDK_PYTHON=/usr/local/opt/python@3.7/bin/python3.7
if [ -f "$HOME/bin/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/bin/google-cloud-sdk/path.zsh.inc"; fi
if [ -f "$HOME/bin/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/bin/google-cloud-sdk/completion.zsh.inc"; fi

source ~/.config/expel-env.sh
source ~/dotfiles/iterm-color-ssh.sh

alias gs="git status"
alias gd="git diff"
alias gdc="git diff --cached"
alias gl='git log'
alias baty='bat -l yaml'

autoload -U colors && colors
# https://salferrarello.com/zsh-git-status-prompt/
autoload -Uz add-zsh-hook vcs_info
setopt prompt_subst
add-zsh-hook precmd vcs_info
zstyle ':vcs_info:*' check-for-changes true
# add ${vcs_info_msg_0} to the prompt
zstyle ':vcs_info:*' unstagedstr ' *'
zstyle ':vcs_info:*' stagedstr ' +'
zstyle ':vcs_info:git:*' formats       '(%b%u%c)'
zstyle ':vcs_info:git:*' actionformats '(%b|%a%u%c)'

source <(kubectl completion zsh)

plugins=(git kubectl docker)

precmd_functions+=(powerline_precmd)
function powerline_precmd() {
  export PS1="$(${HOME}/bin/powerline-go -theme solarized-dark16 -modules kube,cwd,git -error $? -jobs ${${(%):%j}:-0} -newline)"
}
# Older version of PS1:
# export PS1="%{$fg[green]%}%n%{$reset_color%} %{$fg[blue]%}%m %{$fg[yellow]%}%~ %{$fg[grey]%} %# " # ${vcs_info_msg_0_}%f %# "

# export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
# [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
alias code="/Applications/Visual\ Studio\ Code.app/Contents/MacOS/Electron"
alias python=python3

autoload -U select-word-style
select-word-style bash

eval `ssh-agent`
ssh-add --apple-use-keychain

# https://cloud.google.com/blog/products/containers-kubernetes/kubectl-auth-changes-in-gke
export USE_GKE_GCLOUD_AUTH_PLUGIN=True
if [[ -n ${HOME}/.docker/init-zsh.sh ]]; then
  source ${HOME}/.docker/init-zsh.sh
fi
alias k=kubectl

function coauth () {
  echo "Co-authored-by: $1 <${2}@${3:-expel.io}>"
}

setopt share_history
