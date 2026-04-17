#!/usr/bin/env bash

set -e
cd ~/nixos-config

git add . 
cd ~/.config
git add btop/
git add cava/
git add hypr/
git add kitty/
git add nvim/
git add spicetify/
git add swaync/
git add syncthing/
git add waybar/
git add wlogout/
git add yazi/
git add rofi/
cd ~/nixos-config
echo "Starte Rebuild für Host:"
sudo nixos-rebuild switch --flake .#nixos -v

if [ -z "$1" ]; then
	COMMIT_MSG="Auto-Rebuild: $(date +'%Y-%m-%d %H:%M:%S')"
else
	COMMIT_MSG="$1"
fi

if git diff --cached --quiet; then
	cd ~
	echo "Rebuild erfolgreich, aber keine neuen Änderungen zum Commiten"
	notify-send "Rebuild erfolgreich, aber kein Commit"
else    
	cd ~
	git commit -m "$COMMIT_MSG"
	echo "Rebuild erfolgreich und erfolgreich committet: $COMMIT_MSG"
	notify-send "Rebuild erfolgreich: $COMMIT_MSG"
fi

cd ~
