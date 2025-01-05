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
		-theme-str 'textbox-prompt-colon {str: "󰖪";}' \
		-dmenu \
		-markup-rows \
		-theme ${theme} \
		-i -selected-row 0 # -normal-window -steal-focus \
}

#----------------------------------------------------------------------------------------------------

# Get connected displays
DISPLAYS=$(xrandr --query | grep ' connected' | cut -d' ' -f1)
NO_DISPLAYS=$(xrandr --query | grep ' disconnected' | cut -d' ' -f1)

# Check if there are more than one display
if [ $(echo "$DISPLAYS" | wc -l) -gt 1 ]; then
	# Choose display mode
	mode=$(echo -e "Mirror\nSend\nExtend Right\nExtend Left" | rofi_cmd)

	if [[ -n "$mode" ]]; then
		if [[ "$mode" == "Mirror" ]]; then
			xrandr --output $(echo "$DISPLAYS" | head -n 1) --auto --output $(echo "$DISPLAYS" | tail -n 1) --auto --same-as $(echo "$DISPLAYS" | head -n 1)
		elif [[ "$mode" == "Send" ]]; then
			xrandr --output $(echo "$DISPLAYS" | head -n 1) --off  --output $(echo "$DISPLAYS" | tail -n 1) --auto --primary 
		elif [[ "$mode" == "Extend Right" ]]; then
			xrandr --output $(echo "$DISPLAYS" | head -n 1) --left-of $(echo "$DISPLAYS" | tail -n 1)
		elif [[ "$mode" == "Extend Left" ]]; then
			xrandr --output $(echo "$DISPLAYS" | head -n 1) --right-of $(echo "$DISPLAYS" | tail -n 1)
		else
			exit
		fi
	else
		exit
	fi
else
	xrandr --output "$NO_DISPLAYS" --off
	xrandr --output "$DISPLAYS" --primary
	xrandr --output "$DISPLAYS" --auto
	echo -e "Only 1 Display. Try later" | rofi_cmd
	exit
fi
