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

function school()
{
  cs "$HOME/Documents/School/Fall_17/$1"*
}
export -f school
