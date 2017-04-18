#!/usr/bin/env bash

declare -i ID
ID=`xinput list | grep -Eio '(touchpad|glidepoint)\s*id\=[0-9]{1,2}' | grep -Eo '[0-9]{1,2}'`

xinput set-prop $ID 'libinput Tapping Enabled' 1
xinput set-prop $ID 'libinput Natural Scrolling Enabled' 1
