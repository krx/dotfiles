#!/bin/sh

# Fix nvidia
xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto
xrandr --dpi 96

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

# Start up audio
pulseaudio --start
pacmd set-card-profile alsa_card.pci-0000_00_1f.3 output:iec958-stereo

# Stary up automounting
devmon &

# Numlock on startx
numlockx &

# I like to disable the touchpad at startup
touchpad.sh &
touch_toggle &

~/.screenlayout/maindual.sh
xsetroot -cursor_name left_ptr &
nitrogen --restore &
compton &
volnoti -t 2 &
xset s off -dpms
nm-applet &
insync start &

# Start whichever DE I feel like using
session=${1:-bspwm}

case $session in
    awesome           ) exec awesome;;
    bspwm             ) exec bspwm;;
    catwm             ) exec catwm;;
    cinnamon          ) exec cinnamon-session;;
    dwm               ) exec dwm;;
    enlightenment     ) exec enlightenment_start;;
    ede               ) exec startede;;
    fluxbox           ) exec startfluxbox;;
    gnome             ) exec gnome-session;;
    gnome-classic     ) exec gnome-session --session=gnome-classic;;
    i3|i3wm           ) exec i3;;
    icewm             ) exec icewm-session;;
    jwm               ) exec jwm;;
    kde               ) exec startkde;;
    mate              ) exec mate-session;;
    monster|monsterwm ) exec monsterwm;;
    notion            ) exec notion;;
    openbox           ) exec openbox-session;;
    unity             ) exec unity;;
    xfce|xfce4        ) exec startxfce4;;
    xmonad            ) exec xmonad;;
    # No known session, try to run it as command
    *) exec $1;;
esac
