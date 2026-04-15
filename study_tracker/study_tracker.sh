log="$HOME/logs/log1.txt"
timer="$HOME/.config/code/study_tracker/timer.txt"
isPaused="$HOME/.config/code/study_tracker/isPaused.txt"
topic=""

startTimer(){
    if [[ $1 == "I" ]]; then
        topic=$(echo "" | dmenu -p "Choose topic")
        echo "$(date +%d.%m.%y\ %T) START "$topic"" >> "$log"
        echo "logged start"
        start=$(date +%s)
        polybar topmiddle &
        while true; do
            now=$(date +%s)
            echo $(( now - start )) > "$timer"
            sleep 1
        done
        else
        pastTime=$(cat $timer)
        start=$(date +%s)
        while true; do
            now=$(date +%s)
            echo $(( now - start + pastTime )) > "$timer"
            sleep 1
        done
    fi
}


finishTimer(){
    echo "$(date +%d.%m.%y\ %T) FINISH $(~/.local/bin/toggl-time.sh)"  >> $log
    echo "logging finished"
    [[ -f "$timer.pid" ]] && kill "$(cat "$timer.pid")" 2>/dev/null
    rm -f "$timer.pid"
    > "$timer"
    pkill -f "polybar topmiddle"
}

togglPause (){
    if [[ "$(cat $isPaused)" == "F" ]]; then
        kill "$(cat "$timer.pid")"
        echo "T" > $isPaused
    else
        startTimer "P" &
        echo $! > "$timer.pid"
        echo "F" > $isPaused
    fi
}

while getopts "sfp" opt; do
    case $opt in
        s)  startTimer "I" &
            echo $! > "$timer.pid"
            echo "F" > $isPaused
            ;;
        f) finishTimer ;;
        p) togglPause ;;
        \?) echo "invalid option"; exit 1;;
    esac
done

