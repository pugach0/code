#!/bin/bash
config="$HOME/.config/study_tracker/"
polybarConfigExample="$PWD/polybarConfigExample.ini"

echo "Do you want to install ST? [Y/N]"
read answer
echo "Do you want to add the polybar modules to your ~/.config/polybar/config.ini file? (examples are located in main directory) [Y/N]"
read answer2

function install(){
    mkdir -p "$config"
    cp -r $PWD/* "$config"
    cp $PWD/study_tracker.sh "$HOME/.local/bin/"
    cp $PWD/toggl-time.sh "$HOME/.local/bin/"
}

function polybarConfigInstall(){
    echo "$(cat "$polybarConfigExample")" >> "$HOME/.config/polybar/config.ini"
}

function quest(){
    if [[ $answer == "Y" ]]; then
        install
    elif [[ $answer == "N" ]]; then
        exit
    else 
        quest
    fi
}
quest

function quest2(){
    if [[ $answer2 == "Y" ]]; then
        polybarConfigInstall
    elif [[ $answer2 == "N" ]]; then
        exit
    else 
        quest2
    fi
}
quest2

echo "Installation successful"
echo "-s for start -f for finish -e for event -o for day off"