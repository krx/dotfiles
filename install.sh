#!/bin/bash

DOTSDIR="$HOME/dotfiles"
cd $DOTSDIR

GLOBIGNORE=".:..:.git:$(basename $0):util:zsh"
shopt -s dotglob

for f in $(echo *)
do
    LINK=$HOME/$f
    if [ ! -d $LINK  ]; then ln -s $DOTSDIR/$f $LINK; fi
done

