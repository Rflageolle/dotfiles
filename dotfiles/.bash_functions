#!/usr/bin/env bash

function cs()
{
  cd "$@" && ls
}
export -f cs

function mkcd()
{
  mkdir $1
  cd $1
}
export -f mkcd
