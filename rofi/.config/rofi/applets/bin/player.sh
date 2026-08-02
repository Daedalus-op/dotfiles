#!/usr/bin/env bash

source "$HOME"/.config/rofi/applets/shared/theme.bash
theme="$type/$style"

# Theme Elements
if [[ ("$theme" == *'type-1'*) || ("$theme" == *'type-3'*) || ("$theme" == *'type-5'*) ]]; then
	list_col='1'
	list_row='6'
elif [[ ("$theme" == *'type-2'*) || ("$theme" == *'type-4'*) ]]; then
	list_col='6'
	list_row='1'
fi

# Rofi CMD
rofi_cmd() {
	rofi -theme-str "listview {columns: $list_col; lines: $list_row;}" \
		-theme-str 'entry {placeholder: "Now Playing";}' \
		-dmenu \
		-markup-rows \
		-theme ${theme} \
		-i -selected-row 0
	# -normal-window -steal-focus \
}

option_1="󰐎 Toggle"
option_2="󰒭 Next"
option_3="󰒮 Previous"
option_4=" Play"
option_5=" Pause"
option_6=" Stop"
option_7="  Increase Volume +10%"
option_8="  Decrease Volume -10%"
option_9="󰈆  Exit"

#----------------------------------------------------------------------------------------------------

action="nil"
players=($(playerctl -l 2>/dev/null))
if [ ${#players[@]} -gt 1 ]; then
	# Build a list of "Title (PlayerID)" to show in rofi
	mapfile -t options < <(for p in "${players[@]}"; do
		title=$(playerctl -p "$p" metadata title 2>/dev/null)
		echo "$title ($p)"
	done)

	chosen=$(printf "%s\n" "${options[@]}" | rofi_cmd)
	# Extract the player ID inside parentheses
	chosen_player=$(echo "$chosen" | sed -E 's/.*\((.*)\)/\1/')
else
	chosen_player="${players[0]}"
fi

echo $chosen_player

if [[ -n "$chosen_player" ]]; then
	while [[ $action != $option_7 || $action != "nil" ]]; do
		action=$(echo -e "$option_1\n$option_2\n$option_3\n$option_4\n$option_5\n$option_6\n$option_7\n$option_8\n$option_9" | rofi_cmd)

		if [[ -n "$action" ]]; then
			case ${action} in
			$option_1)
				playerctl -p $chosen_player play-pause
				;;
			$option_2)
				playerctl -p $chosen_player next
				;;
			$option_3)
				playerctl -p $chosen_player previous
				;;
			$option_4)
				playerctl -p $chosen_player play
				;;
			$option_5)
				playerctl -p $chosen_player pause
				;;
			$option_6)
				playerctl -p $chosen_player stop
				;;
			$option_7)
				playerctl -p $chosen_player volume 0.10+
				;;
			$option_8)
				playerctl -p $chosen_player volume 0.10-
				;;
			$option_9)
				exit
				;;
			esac
		else
			exit
		fi
	done
else
	exit
fi
