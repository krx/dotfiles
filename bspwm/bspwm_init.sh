#!/usr/bin/env zsh

source ~/.zprofile
export PATH

#~/bin/setup-xinput &
xbindkeys &

# Start up audio
#pulseaudio --start
#amixer -c PCH cset 'name=Headphone Mic Boost Volume' 1 &

# get GNOME stuff working
/usr/lib/gsd-xsettings &
/usr/bin/gnome-flashback &
#/usr/bin/gnome-screensaver &

# Start up automounting
#devmon &

xsetroot -cursor_name left_ptr &
compton &
~/.fehbg &
#volnoti -t 2 &
#xset s off -dpms
nm-applet &
blueman-applet &
libinput-gestures-setup start &

# This should already be starting, but let's make sure
insync start &

#sudo tzupdate &
