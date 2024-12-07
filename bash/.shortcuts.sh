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

export KITTY_CONFIG_DIRECTORY="~/.config/kitty"
export LANG=en_US.UTF-8
export STARSHIP_CONFIG=~/.files/starship/.config/starship/pure.toml
# xilset
