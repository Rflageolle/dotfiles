#!/usr/bin/env bash

# Powerline font glyhps
PL_RIGHT_BLACK=$(printf "\\uE0B0")
PL_RIGHT=$(printf "\\uE0B1")
PL_LEFT_BLACK=$(printf "\\uE0B2")
PL_LEFT=$(printf "\\uE0B3")

# tmux values
LEFT_STATUS_LENGTH=$(tmux display -p "#{status-left-length}")
LEFT_STATUS_LENGTH=$((LEFT_STATUS_LENGTH - 4)) # To allow for last divider
STATUS_BG=$(tmux display -p "#{status-bg}")
TMUX_SESSION="$1"

# Status values
tmux_status_left=""
cur_size=0
last_bg=""

function start_section () {
    # 1 Contents
    # 2 Forground colour
    # 3 Background colour
    # 4 Extra formatting
    tmux_status_left="#[fg=$2,bg=$3$4] $1"
    last_bg="$3"
    cur_size=$((cur_size + ${#1}))

    if [[ $cur_size -ge $LEFT_STATUS_LENGTH ]]; then
        end_of_status=$((${#tmux_status_left} - (cur_size - LEFT_STATUS_LENGTH)))
        tmux_status_left="${tmux_status_left:0:end_of_status}"
        end_sections
    fi

    tmux_status_left="$tmux_status_left#[none]"
}

function middle_section () {
    # 1 Contents
    # 2 Forground colour
    # 3 Background colour
    # 4 Extra formatting

    cur_size=$((cur_size + 3))
    if [[ $cur_size -ge $LEFT_STATUS_LENGTH ]]; then
        end_sections
    fi

    if [[ $last_bg = "$3" ]]; then
        tmux_status_left="$tmux_status_left $PL_RIGHT"
    else
        tmux_status_left="$tmux_status_left #[fg=$last_bg,bg=$3]$PL_RIGHT_BLACK"
    fi

    tmux_status_left="$tmux_status_left#[fg=$2,bg=$3$4] $1"
    last_bg="$3"
    cur_size=$((cur_size + ${#1}))

    if [[ $cur_size -ge $LEFT_STATUS_LENGTH ]]; then
        end_of_status=$((${#tmux_status_left} - (cur_size - LEFT_STATUS_LENGTH)))
        tmux_status_left="${tmux_status_left:0:end_of_status}"
        end_sections
    fi

    tmux_status_left="$tmux_status_left#[none]"
}

function end_sections () {
    if [[ $last_bg = "$STATUS_BG" ]]; then
        tmux_status_left="$tmux_status_left $PL_RIGHT "
    else
        tmux_status_left="$tmux_status_left #[fg=$last_bg,bg=$STATUS_BG]$PL_RIGHT_BLACK "
    fi

    echo "$tmux_status_left#[none]"
    exit 0
}

start_section "$TMUX_SESSION" "colour0" "colour7" ",bold"

middle_section "$(whoami)@$(hostname -s)" "colour7" "colour0"

end_sections
