#!/bin/sh
userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps
if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

#Start vmware crap
#vmware-user-suid-wrapper
#sudo vmhgfs-fuse -o allow_other -o auto_unmount .host:/ /mnt/hgfs/

~/bin/setup-xinput &
xbindkeys &

# Start up audio
pulseaudio --start
amixer -c PCH cset 'name=Headphone Mic Boost Volume' 1 &

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

export BSPWM_STATE=/tmp/bspwm-state.json
while true; do
    bspwm || break;
done

