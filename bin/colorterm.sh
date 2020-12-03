#!/bin/bash

#
# author: Bryan Gilbert
# source: https://bryangilbert.com/post/etc/term/dynamic-ssh-terminal-background-colors/
# 
# modifications: bg set to default when exiting, and 'exit 0' to stop the script 
#

if [[ "$TERM" = "tmux"* ]] && [[ -n "$TMUX" ]]; then
  if [ "$1" == "prod" ]; then
    tmux select-pane -P 'bg=#331C1F';
  elif [ "$1" == "dev" ]; then
    tmux select-pane -P 'bg=#192436';
  elif [ "$1" == "vpn" ]; then
    tmux select-pane -P 'bg=#362A19';
  elif [ "$1" == "other" ]; then
    tmux select-pane -P 'bg=#253320';
  else
    tmux select-pane -P 'bg=default';
  fi;
else
  if [ "$1" == "prod" ]; then
    printf '\033]11;#331C1F\007';
  elif [ "$1" == "dev" ]; then
    printf '\033]11;#192436\007';
  elif [ "$1" == "other" ]; then
    printf '\033]11;#253320\007';
  else
    printf '\033]11;#1b1b1b\007';
  fi
fi

exit 0

