#!/usr/bin/env bash

# Terminate already running bar instances
killall -q -9 polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch all bars
for mon in $(polybar -m | sed -E 's/:.+//g'); do
    MONITOR=$mon polybar top &
    if [[ $mon == "eDP-1" ]]; then
        polybar bot &
    else
        MONITOR=$mon polybar extbot &
    fi
done

echo "Bars launched..."
