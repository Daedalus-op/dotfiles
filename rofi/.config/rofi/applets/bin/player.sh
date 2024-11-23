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
		-normal-window -steal-focus \
		-i -selected-row 0
}


#----------------------------------------------------------------------------------------------------

players=$(playerctl -l)
echo $players

chosen_player=$(echo -e "$players" | rofi_cmd )
echo $chosen_player

if [[ -n "$chosen_player" ]]; then
	echo hello
	action=$(echo -e "toggle\nplay\npause\nstop\nprevious\nnext" | rofi_cmd  )

	if [[ -n "$action" ]]; then
		if [[ $action == "toggle" ]]; then
			playerctl -p $chosen_player play-pause
		else
			playerctl -p $chosen_player $action
		fi
	else
		exit
	fi
else
	echo adhh
	exit
fi
echo etp3
