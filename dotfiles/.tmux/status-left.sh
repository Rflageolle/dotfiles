#!/usr/bin/env bash

# Powerline font glyhps
PL_RIGHT_BLACK=$(printf "\uE0B0")
PL_RIGHT=$(printf "\uE0B1")
PL_LEFT_BLACK=$(printf "\uE0B2")
PL_LEFT=$(printf "\uE0B3")

# tmux values
LENGTH=$(tmux display -p "#{status-left-length}")
SESSION=$(tmux display -p "#S")

echo "#[fg=colour0,bg=colour2,bold] $SESSION $PL_RIGHT #(whoami)@#(hostname -s) \
#[fg=colour2,bg=colour0]$PL_RIGHT_BLACK "
