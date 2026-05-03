#!/bin/zsh
timer="$HOME/.config/study_tracker/timer.txt"

if [[ ! -f "$timer" ]] || [[ ! -s "$timer" ]]; then
    echo "00:00:00"
    exit 0
fi

sInit=$(cat "$timer")
h=$(( sInit / 3600 ))
printf -v hp "%02d" "$h"
mInit=$(( sInit / 60 ))
m=$(( (sInit / 60) - (h * 60) ))
printf -v mp "%02d" "$m"
s=$(( sInit - (mInit * 60) ))
printf -v sp "%02d" "$s"

sketchybar --set timer label="$hp:$mp:$sp"