#!/usr/bin/env bash

function setup_monitor() {
    bspc monitor $1 -d $1/1 $1/2 $1/3 $1/4 $1/5 $1/6 $1/7 $1/8 $1/9 $1/10
}

function delete_monitor() {
    # Gather all unoccupied desktops on the primary monitor
    PRIMARY=$(bspc query -M -m primary)
    DSK_TO=($(bspc query -D -d '.!occupied' --names | grep "$PRIMARY"))

    # Count how many desktops need to be moved, compute total # desktops needed
    DSK_FROM=($(bspc query -D --names -d '.occupied' | grep "$1"))
    TOTAL=$(( 10 - ${#DSK_TO[@]} + ${#DSK_FROM[@]} ))

    # Add additional desktops to the primary monitor as needed
    for i in $(seq 11 ${TOTAL}); do
        bspc monitor $PRIMARY -a $PRIMARY/$i
        DSK_TO+=("$PRIMARY/$i")
    done

    # Move nodes from all occupied desktops getting deleted
    for i in $(seq 0 $((${#DSK_FROM[@]} - 1))); do
        # Move the root node of the deleted desktop to the new desktop
        NODES=($(bspc query -N -d ${DSK_FROM[$i]}))
        bspc node ${NODES[0]} -d ${DSK_TO[$i]}
    done

    # Delete the old desktops
    for i in {1..10}; do
        bspc desktop "$1/$i" -r
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
