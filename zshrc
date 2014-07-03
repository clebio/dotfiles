#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

autoload -U compinit
compinit



bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

for config_file ($HOME/.yadr/zsh/*.zsh) source $config_file
source /usr/local/bin/virtualenvwrapper.sh
alias vdown="VBoxManage controlvm precise64 savestate"
alias vup="VBoxHeadless --startvm precise64 &"
alias svag="ssh -p 2222 localhost"

bindkey -e
bindkey '[C' forward-word
bindkey '[D' backward-word

alias emacs="/Applications/Emacs.app/Contents/MacOS/Emacs -nw"
export ODBCINI=~/.odbc.ini
alias rds="isql Controller devuser brighten136"
alias redshift='psql -h devcluster.c7xw1jangqta.us-east-1.redshift.amazonaws.com -U devuser -d gatest -p 5439'
alias generaldb='isql General v4_user tropics_2011'
source /usr/local/aws/bin/aws_zsh_completer.sh
alias ec2ssh="ssh -i ~/.ssh/DataTeam.pem  ubuntu@\$(aws opsworks describe-stacks --query 'Stacks[1].StackId'  --output text | xargs -I {} aws opsworks describe-instances --stack-id {} --query 'Instances[*].PublicIp' --output text)"
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
