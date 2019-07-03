#!/bin/bash

while :
do
  clear
  git -P log -10 --graph --all \
    --pretty='%Cred%h%Creset| %C(yellow)%d%Creset %f %Cgreen(%cr)%Creset %C(cyan)[%an]%Creset' \
    --decorate \
    --abbrev-commit \
    --date=relative
  sleep 1
done
