#!/bin/bash
config="$HOME/.config/study_tracker/"
repo="$HOME/study_tracker"

rm -rf "$repo"
git clone "https://github.com/pugach0/study_tracker.git" "$repo"
mkdir -p "$config"
cp -r "$repo"/* "$config"
cp "$repo/study_tracker.sh" "$HOME/.local/bin/"
cp "$repo/toggl-time.sh" "$HOME/.local/bin/"
cp "$repo/STupdate.sh" "$HOME/.local/bin/"
chmod +x "$HOME/.local/bin/STupdate.sh/"
echo "update successful"