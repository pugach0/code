log="$HOME/logs/log1.txt"
timer="$HOME/.config/code/variables/st/timer.txt"
isPaused="$HOME/.config/code/variables/st/isPaused.txt"
topic="$HOME/.config/code/variables/st/topic.txt"

startTimer(){
    if [[ $1 == "I" ]]; then
        dmenu -p "Choose topic" < /dev/null > "$topic"
        #echo "$(date +%d.%m.%y\ %T) START "$topic"" >> "$log"
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
    echo "$(date +%d.%m.%y\ %T) FINISH $(~/.config/code/study_tracker/timer/toggl-time.sh) $(cat $topic)"  >> $log #breaks website if topic with spaces
    echo "logging finished"
    [[ -f "$timer.pid" ]] && kill "$(cat "$timer.pid")" 2>/dev/null
    rm -f "$timer.pid"
    > "$timer"
    pkill -f "polybar topmiddle"
    pkill -f "study"
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

addEvent(){
    event=$(echo "" | dmenu -p "Add event")
    echo "$(date +%d.%m.%y\ %T) EVENT ${event// /_}" >> $log
}

while getopts "sfpe" opt; do
    case $opt in
        s) 
	    startTimer "I" &
            echo $! > "$timer.pid"
            echo "F" > $isPaused
            ;;
        f) finishTimer ;;
        p) togglPause ;;
        e) addEvent ;;
        \?) echo "invalid option"; exit 1;;
    esac
done

