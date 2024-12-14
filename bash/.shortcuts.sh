# starship
eval "$(starship init bash)"

# alias
## updates and installs
function maintain {
	echo "---Apt update------------------------------------------------------------------------------------------------------"
	sudo apt update
	echo "---Apt upgrade------------------------------------------------------------------------------------------------------"
	sudo apt upgrade
	echo "---Apt autoremove------------------------------------------------------------------------------------------------------"
	sudo apt autoremove
	echo "---Flatpak update------------------------------------------------------------------------------------------------------"
	flatpak update
	echo "---Flatpak clean------------------------------------------------------------------------------------------------------"
	flatpak uninstall --unused --delete-data
	echo "----------------------------------------------Maintain done--------------------------------------------------------"
}

# Functions
## obsidian note sync
function notes {
	cd ~/Desktop/Notes/sync
	git pull
	git add .
	git commit -m"$( date '+%F') backup"
	git push
	exit
}

function autostart {
	if [ "$DESKTOP_SESSION" == "awesome" ]; then
		cd ~/.files
		git checkout clean 2>/dev/null
		cd
		copyq &
		xinput set-prop 12 'libinput Tapping Enabled' 1
		xinput set-prop 12 'libinput Natural Scrolling Enabled' 1
		feh --bg-scale ~/.customise/Wallpapers/Scenery/Layer_Mountain.jpg
		libinput-gestures-setup start
	elif [[ "$DESKTOP_SESSION" == "ubuntu-wayland" ]]; then
		cd ~/.files
		git checkout master 2>/dev/null
		cd
	fi
}

export KITTY_CONFIG_DIRECTORY="~/.config/kitty"
export LANG=en_US.UTF-8
export STARSHIP_CONFIG=~/.files/starship/.config/starship/pure.toml
# xilset
