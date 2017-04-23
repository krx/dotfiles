#!/usr/bin/env bash

declare -i ID
while [[ -z $ID ]]; do
    sleep 0.5
    ID=`xinput list | grep -Eio '(touchpad|glidepoint)\s*id\=[0-9]{1,2}' | grep -Eo '[0-9]{1,2}'`
done

xinput set-prop $ID 'libinput Tapping Enabled' 1
xinput set-prop $ID 'libinput Natural Scrolling Enabled' 1
