#!/usr/bin/env bash

source "$HOME"/.config/rofi/applets/shared/theme.bash
theme="$type/$style"

# Theme Elements
if [[ ( "$theme" == *'type-1'* ) || ( "$theme" == *'type-3'* ) || ( "$theme" == *'type-5'* ) ]]; then
	list_col='1'
	list_row='6'
elif [[ ( "$theme" == *'type-2'* ) || ( "$theme" == *'type-4'* ) ]]; then
	list_col='6'
	list_row='1'
fi

# Rofi CMD
rofi_cmd() {
	rofi -theme-str "listview {columns: $list_col; lines: $list_row;}" \
		-theme-str 'textbox-prompt-colon {str: "󰖪";}' \
		-dmenu \
		-markup-rows \
		-theme ${theme} \
		# -normal-window -steal-focus \
		-i -selected-row 0
}

option_1="󰐎 Toggle"
option_2=" Play"
option_3=" Pause"
option_4=" Stop"
option_5="󰒮 Previous"
option_6="󰒭 Next"
option_7="  Increase Volume +10%"
option_8="  Decrease Volume -10%"
option_9="󰈆  Exit"

#----------------------------------------------------------------------------------------------------

action="nil"
players=$(playerctl -l)
echo $players

chosen_player=$(echo -e "$players" | rofi_cmd )
echo $chosen_player

if [[ -n "$chosen_player" ]]; then
	while [[ $action != $option_7 || $action != "nil" ]]; do
		action=$(echo -e "$option_1\n$option_2\n$option_3\n$option_4\n$option_5\n$option_6\n$option_7\n$option_8\n$option_9" | rofi_cmd  )

		if [[ -n "$action" ]]; then
			case ${action} in
				$option_1)
					playerctl -p $chosen_player play-pause
					;;
				$option_2)
					playerctl -p $chosen_player play
					;;
				$option_3)
					playerctl -p $chosen_player pause
					;;
				$option_4)
					playerctl -p $chosen_player stop
					;;
				$option_5)
					playerctl -p $chosen_player previous
					;;
				$option_6)
					playerctl -p $chosen_player next
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
