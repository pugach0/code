#!/bin/bash
config="$HOME/.config/study_tracker/"
cd $HOME
rm -rf "$HOME/study_tracker/"
git clone "https://github.com/pugach0/study_tracker.git"
cd "study_tracker"
mkdir -p "$config"
cp -r $PWD/* "$config"
cp $PWD/study_tracker.sh "$HOME/.local/bin/"
cp $PWD/toggl-time.sh "$HOME/.local/bin/"
echo "update successful"