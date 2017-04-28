#!/usr/bin/env bash

function setup_monitor() {
    bspc monitor $1 -d $1/1 $1/2 $1/3 $1/4 $1/5 $1/6 $1/7 $1/8 $1/9 $1/10
}

function delete_monitor() {
    # Choose the first unoccupied desktop to throw all nodes in
    # If all are occupied, and the old desktop is moved over
    DESKS=($(bspc query -D -d '.!occupied' -m primary)) && TO=${DESKS[0]}

    # Move nodes from all occupied desktops getting deleted
    for i in {1..10}; do
        # Move the root node of the deleted desktop to the new desktop
        NODES=($(bspc query -N -d $1/$i)) && bspc node ${NODES[0]} -d $TO

        # Delete the desktop
        bspc desktop $1/$i -r
    done
}

# Initally setup all monitors
for mon in $(bspc query -M); do
    setup_monitor $mon
done

# Subscribe to monitor events
kill $(pgrep -f 'bspc subscribe monitor')
bspc subscribe monitor | while read line; do
    ev=($line)
    if [[ ${ev[0]} == "monitor_remove" ]]; then
        delete_monitor ${ev[1]}

        # Relaunch polybar
        ~/.config/polybar/launch.sh
    elif [[ ${ev[0]} == "monitor_add" ]]; then
        setup_monitor ${ev[1]}

        # Relaunch polybar
        ~/.config/polybar/launch.sh
    fi

    # Either way, fix the wallpaper
    $HOME/.fehbg &
done

