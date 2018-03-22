#!/usr/bin/env bash

# Powerline font glyhps
PL_RIGHT_BLACK=$(printf "\uE0B0")
PL_RIGHT=$(printf "\uE0B1")
PL_LEFT_BLACK=$(printf "\uE0B2")
PL_LEFT=$(printf "\uE0B3")

# tmux values
LENGTH=$(tmux display -p "#{status-left-length}")
SESSION=$(tmux display -p "#S")

# Status values
status=""
size=0
last_bg=""

# the first section
function start_section () {
    # 1 Contents
    # 2 Forground colour
    # 3 Background colour
    # 4 Extra formatting
    status="#[fg=$2,bg=$3$4]$1"
    last_bg="$3"
    size=$(($size + ${#1}))
}

function end_sections () {
    status="$status #[fg=$last_bg,bg=black]$PL_RIGHT_BLACK "
    echo $status
    exit 0
}

start_section "$SESSION" "colour0" "colour2" ",bold"

end_sections

echo "#[fg=colour0,bg=colour2,bold] $SESSION $PL_RIGHT #(whoami)@#(hostname -s) \
#[fg=colour2,bg=colour0]$PL_RIGHT_BLACK "
