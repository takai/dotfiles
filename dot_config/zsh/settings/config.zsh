LANG=ja_JP.UTF-8

EDITOR=vim
WORDCHARS="*?_-.[]~=&;!#$%^(){}<>"

alias ls='ls -G -B -w'

if [ -f ~/.zsh-local ]; then
  . ~/.zsh-local
fi
