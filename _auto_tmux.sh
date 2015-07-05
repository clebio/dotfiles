
if [[ -z "$TMUX" ]]; then
    tmux has-session &> /dev/null
    if [ $? -eq 1 ]; then
      exec tmux -2 new

      exit
    else
      exec tmux attach
      exit
    fi
fi

