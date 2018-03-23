#!/usr/bin/env bash

#Powerline font glyhps
PL_RIGHT_BLACK=$(printf "\\uE0B0")
PL_RIGHT=$(printf "\\uE0B1")
PL_LEFT_BLACK=$(printf "\\uE0B2")
PL_LEFT=$(printf "\\uE0B3")

# tmux values
LEFT_STATUS_LENGTH=$(tmux display -p "#{status-left-length}")
RIGHT_STATUS_LENGTH=$(tmux display -p "#{status-right-length}")
CLIENT_WIDTH="$1"
STATUS_BG=$(tmux display -p "#{status-bg}")

max_width=$((CLIENT_WIDTH - LEFT_STATUS_LENGTH - 10))

if [[ $RIGHT_STATUS_LENGTH -lt "$max_width" ]]; then
    max_width="$RIGHT_STATUS_LENGTH"
fi

# Status values
tmux_status_right=""
cur_size=0
last_bg=""

# String parts
TIME_STR=$(date +"%l:%M %p %Z")
DATE_STR=$(date +"%a %b %d")

echo " #[fg=colour6,bg=colour0]$PL_LEFT_BLACK\
#[fg=colour0,bg=colour6,bold] $DATE_STR \
#[fg=colour3,bg=colour6]$PL_LEFT_BLACK\
#[fg=colour0,bg=colour3,bold] $TIME_STR "
