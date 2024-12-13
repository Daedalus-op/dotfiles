#!/usr/bin/env bash

source "$HOME"/.config/rofi/applets/shared/theme.bash
theme="$type/$style"

# Theme Elements
prompt="`hostname`"
mesg="Uptime : `uptime -p | sed -e 's/up //g'`"

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
		-p "Alias: " \
		-mesg "$mesg" \
		-markup-rows \
		-theme ${theme} \
		# -normal-window -steal-focus \
		-i -selected-row 1
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$option_1\n$option_2\n$option_3\n$option_4\n$option_5\n$option_6" | rofi_cmd
}

#----------------------------------------------------------------------------------------------------

alias he="echo help"
source /home/xubundadu/.shortcuts.sh

# Get list of all aliases
aliases=$(alias -p | sed 's/alias //; s/=\(.*\)//' )

# Use rofi to select wifi network
chosen_alias=$(echo -e "Aliases\n$aliases" | uniq -u | rofi_cmd  )
echo $chosen_alias

# if [[ "$chosen_alias" = "" ]]; then
# 	exit
# else
  	success_message="$chosen_alias executed."
	#echo '$status=\"\' > .temp
	#exec bash -c "~/.shortcuts.sh && $chosen_alias 2>> .temp"
	$chosen_alias && status="Success"
	echo $status
	if [[ $status = "Success" ]]; then
		echo -e $success_message | rofi -show -dmenu -steal-focus -normal-window -theme ${theme}
	fi
# fi
