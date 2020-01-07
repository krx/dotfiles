#!/usr/bin/env bash

source ~/.zprofile
export PATH

~/bin/setup-xinput &
xbindkeys &

# Start up audio
#pulseaudio --start
#amixer -c PCH cset 'name=Headphone Mic Boost Volume' 1 &

# Start up automounting
devmon &

xsetroot -cursor_name left_ptr &
compton &
~/.fehbg &
volnoti -t 2 &
xset s off -dpms
nm-applet &
blueman-applet &

# This should already be starting, but let's make sure
insync start &

sudo tzupdate
