#!/usr/bin/env bash

# Powerline font glyhps
PL_RIGHT_BLACK=$(printf "\uE0B0")
PL_RIGHT=$(printf "\uE0B1")
PL_LEFT_BLACK=$(printf "\uE0B2")
PL_LEFT=$(printf "\uE0B3")

# String parts
TIME_STR=$(date +"%l:%M %p %Z")
DATE_STR=$(date +"%a %b %d")


echo "$(whoami)@$(hostname -s) \
#[fg=colour6,bg=colour0]$PL_LEFT_BLACK\
#[fg=colour0,bg=colour6,bold] $DATE_STR \
#[fg=colour3,bg=colour6]$PL_LEFT_BLACK\
#[fg=colour0,bg=colour3,bold] $TIME_STR "
