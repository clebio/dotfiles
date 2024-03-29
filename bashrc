# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
export CLICOLOR=1
export TERM=xterm-256color
# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=200000
#HISTFILE="${HOME}/.history/$(date -u +%Y/%m/%d.%H.%M.%S)_$$"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
   # unicode for return value visualisation
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

if [ -f ~/.bashprompt.rc ]; then
    source ~/.bashprompt.rc
fi
if [ -f ~/.git-completion.bash ]; then
   source ~/.git-completion.bash
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
else
    alias ls="ls -G"
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

export PATH=$PATH:/usr/local/sbin
export PATH=$PATH:/usr/local/go/bin

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

alias winefox='wine /home/caleb/.wine/drive_c/Program\ Files\ \(x86\)/Mozilla\ Firefox/firefox.exe >& /dev/null &'
alias emacs='emacs -nw'
alias wemacs='/usr/local/bin/emacs'
alias ekill="emacsclient -e '(kill-emacs)'"
alias svag='ssh -X -p 2222 localhost'
alias nunit="mono ~/bin/nunit/nunit3-console.exe"

if command -v git > /dev/null
then 
    alias lg="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
    alias gl="git log"
    alias gd="git diff"
    alias gs="git status"
    alias gt="git tag -l --format='%(refname:strip=2) -- %(subject)'"
fi

alias gobug='dlv debug --headless --listen=:2345 --log'

export PATH="$HOME/.rvm/bin:$PATH" # Add RVM to PATH for scripting
export PATH="$HOME/bin:$PATH"
#export PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
export PATH=$PATH:/Library/Frameworks/Mono.framework/Versions/Current/bin
export PATH="/usr/local/Cellar/python3/3.6.2/bin:/usr/local/Cellar/python/2.7.13_1/bin:$PATH"
#eval $(docker-machine env default)
complete -C '/usr/local/bin/aws_completer' aws
stty erase ^?

#Android SDK
export PATH=$PATH:~/Library/Android/sdk/platform-tools/
export AWS_DEFAULT_PROFILE=default

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/caleb/bin/google-cloud-sdk/path.bash.inc' ]; then source '/Users/caleb/bin/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/caleb/bin/google-cloud-sdk/completion.bash.inc' ]; then source '/Users/caleb/bin/google-cloud-sdk/completion.bash.inc'; fi

# http://boredzo.org/blog/archives/2016-08-15/colorized-man-pages-understood-and-customized
man() {
    env \
        LESS_TERMCAP_mb=$'\e[1;31m' \
        LESS_TERMCAP_md=$'\e[1;31m' \
        LESS_TERMCAP_me=$'\e[0m' \
        LESS_TERMCAP_se=$'\e[0m' \
        LESS_TERMCAP_so=$'\e[1;44;33m' \
        LESS_TERMCAP_ue=$'\e[0m' \
        LESS_TERMCAP_us=$'\e[1;32m' \
            man "$@"
}

## https://unix.stackexchange.com/a/1292 (or https://askubuntu.com/a/339925)
# Avoid duplicates
export HISTCONTROL=ignoredups:erasedups
# When the shell exits, append to the history file instead of overwriting it
shopt -s histappend
# After each command, append to the history file and reread it
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"
export PATH=$PATH:${HOME}/.local/bin
source /home/caleb/.rvm/scripts/rvm
