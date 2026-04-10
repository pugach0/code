log="$HOME/.config/code/study_tracker/log1.txt"
timer="$HOME/.config/code/study_tracker/timer.txt"

startTimer(){
    echo "$(date +%d.%m.%y\ %T) START" >> "$log"
    start=$(date +%s)
    while true; do
        now=$(date +%s)
        echo $(( now - start )) > "$timer"
        sleep 1
    done
}


finishTimer(){
    echo $(date +%d.%m.%y\ %T) FINISH $(~/.local/bin/toggl-time.sh)  >> $log
    [[ -f "$timer.pid" ]] && kill "$(cat "$timer.pid")" 2>/dev/null
    rm -f "$timer.pid"
    > "$timer"
}

while getopts "sf" opt; do
    case $opt in
        s)  [[ -f "$timer.pid" ]] && kill "$(cat "$timer.pid")" 2>/dev/null
            startTimer &
            echo $! > "$timer.pid"
            ;;
        f) finishTimer ;;
        \?) echo "invalid option"; exit 1;;
    esac
done

