#!/usr/bin/env bash
pac=$(checkupdates | wc -l)
aur=$(cower -u | wc -l)
echo "$pac %{F#b16286}%{F-} $aur"

