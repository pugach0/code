#!/bin/bash
timer="$HOME/.config/study/timer.txt"
sInit=$(cat "$timer")
h=$(( sInit / 3600 ))
mInit=$(( sInit / 60 ))
m=$(( (sInit / 60) - (h * 60) ))
s=$(( sInit - (mInit * 60) ))

echo "$h:$m:$s"
