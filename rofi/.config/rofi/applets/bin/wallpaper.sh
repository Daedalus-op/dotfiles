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

# Get a list of available wifi connections and morph it into a nice-looking list
categories=$(cd $HOME/.customise/Wallpapers/ && ls)

chosen_cat=$(echo -e "$categories" | uniq -u | rofi_cmd  )

# setting background for kitty, todo

  if [[ -n "$chosen_cat" ]]; then
    wall_list=$(cd $HOME/.customise/Wallpapers/$chosen_cat && ls)
    wallpaper=$(echo -e "$wall_list" | uniq -u | rofi_cmd  )

    if [[ -n "$wallpaper" ]]; then
		wal -i "$HOME/.customise/Wallpapers/$chosen_cat/$wallpaper"
		feh --bg-scale "$HOME/.customise/Wallpapers/$chosen_cat/$wallpaper"
		sed -i "s|background_image.*|background_image ~/.customise/Wallpapers/$chosen_cat/$wallpaper|" $HOME/.config/kitty/variables.conf
		sed -i "s|^    background-image:.*|    background-image:\t\t\turl(\"~/.customise/Wallpapers/$chosen_cat/$wallpaper\", height);|" ~/.config/rofi/applets/type-5/style.rasi 
		sed -i "s|feh.*|feh --bg-scale ~/.customise/Wallpapers/$chosen_cat/$wallpaper\")|" $HOME/.config/awesome/rc.lua
    else
      exit
    fi

  else
    exit
  fi
