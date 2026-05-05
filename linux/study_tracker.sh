log="$HOME/.config/logs/log1.txt"
timer="$HOME/.config/code/variables/st/timer.txt"
isPaused="$HOME/.config/code/variables/st/isPaused.txt"
topic="$HOME/.config/code/variables/st/topic.txt"
events="$(grep "FINISH" "$log")"

startTimer(){
    if [[ $1 == "I" ]]; then
        topicTmp=$(echo "" | dmenu -p "Choose topic")
        if [[ $topicTmp == "Q" ]]; then exit; fi
        echo "${topicTmp// /_}" > $topic
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
    if [[ $(cat $timer) == "0" ]]; then 
        exit
    fi
    echo "$(date +%d.%m.%y\ %T) FINISH $(~/.config/code/study_tracker/timer/toggl-time.sh) $(cat $topic)"  >> $log 
    echo "logging finished"
    [[ -f "$timer.pid" ]] && kill "$(cat "$timer.pid")" 2>/dev/null
    rm -f "$timer.pid"
    > "$timer"
    pkill -f "polybar topmiddle"
    pkill -f "study"
}

addEvent(){
    event=$(echo "" | dmenu -p "Add event")
    if [[ $event == "Q" ]]; then 
        exit
    fi
    if [[ $event =~ ^[0-9]{2}\.[0-9]{2}\.[0-9]{2}$ ]]; then 
        sed -i "/EVENT/ { /$event/d; }" "$log"
        exit
    fi
    echo "$(date +%d.%m.%y\ %T) EVENT ${event// /_}" >> $log
}

dayOff(){
    dateOff=$(echo "" | dmenu -p "Enter date -d argument")
    if [[ $dateOff =~ ^R\ [0-9]{2}\.[0-9]{2}\.[0-9]{2}$ ]]; then 
        sed -i "/DAYOFF/ { /${dateOff:2}/d; }" "$log"
        exit
    fi
    formattedDate=$(date -d "$dateOff" +%d.%m.%y 2>> "$log")
    if [[ $? -eq 0 && -n "$dateOff" ]]; then
        echo "$formattedDate DAYOFF" >> $log
    elif [[ $dateOff =~ Q ]]; then
        dayOff
    fi
    exit
}

#^[0-9]{2}\.[0-9]{2}\.[0-9]{2}$

while getopts "sfpeo" opt; do
    case $opt in
        s) 
	    startTimer "I" &
            echo $! > "$timer.pid"
            echo "F" > $isPaused
            ;;
        f) finishTimer ;;
        e) addEvent ;;
        o) dayOff ;;
        \?) echo "invalid option"; exit 1;;
    esac
done

