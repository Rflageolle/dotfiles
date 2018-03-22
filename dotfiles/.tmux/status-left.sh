#!/usr/bin/env bash

# Powerline font glyhps
PL_RIGHT_BLACK=$(printf "\\uE0B0")
PL_RIGHT=$(printf "\\uE0B1")
PL_LEFT_BLACK=$(printf "\\uE0B2")
PL_LEFT=$(printf "\\uE0B3")

# tmux values
STAT_LENGTH=$(tmux display -p "#{status-left-length}")
STAT_LENGTH=$((STAT_LENGTH - 4)) # To allow for last divider
TMUX_SESSION=$(tmux display -p "#S")

# Status values
tmux_status_left=""
cur_size=0
last_bg=""

# the first section
function start_section () {
    # 1 Contents
    # 2 Forground colour
    # 3 Background colour
    # 4 Extra formatting
    tmux_status_left="#[fg=$2,bg=$3$4] $1"
    last_bg="$3"
    cur_size=$((cur_size + ${#1}))

    if [[ $cur_size -ge $STAT_LENGTH ]]; then
        difference=$((STAT_LENGTH - cur_size))
        tmux_status_left=${tmux_status_left:0:difference}
        end_sections
    fi
}

function end_sections () {
    tmux_status_left="$tmux_status_left #[fg=$last_bg,bg=black]$PL_RIGHT_BLACK "
    echo "$tmux_status_left"
    exit 0
}

start_section "$TMUX_SESSION" "colour0" "colour2" ",bold"

end_sections

echo "#[fg=colour0,bg=colour2,bold] $TMUX_SESSION $PL_RIGHT #(whoami)@#(hostname -s) #[fg=colour2,bg=colour0]$PL_RIGHT_BLACK "
