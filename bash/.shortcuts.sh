# Shell inits
## Starship
eval "$(starship init bash)"

## Z lua script
eval "$(lua ~/.files/z.lua --init bash enhanced once fzf)" # fzf tab completion

# Functions
## LFCD
LFCD="$HOME/.config/lf/lfcd.sh"
if [ -f "$LFCD" ]; then
	source "$LFCD"
fi
bind '"\C-o":"lfcd\C-m"'
bind '"\C-h":"navi\C-m"'

hist_fzf() {
	local selected_command
	selected_command=$(history | sed 's/^[ ]*[0-9]\+[ ]*//' | sort | uniq -u | fzf --tac --height 40% --reverse --no-sort)
	if [ -n "$selected_command" ]; then
		# Extract the command from the history output
		command_to_run=$(echo "$selected_command" | sed 's/^[ ]*[0-9]\+[ ]*//')
		eval "$command_to_run"
		# READLINE_LINE="$command_to_run"
		# READLINE_POINT=${#READLINE_LINE}
	fi
}
# bind '"\C-r":"hist_fzf\C-m"'

## Updates and Installs
function maintain {
	echo "--- Aptitude update -------- ($(date +"%Y-%m-%d %H:%M")) ------------------------------------------------------------------"
	sudo aptitude update
	echo "--- Aptitude upgrade ------------------------------------------------------------------------------------------------------"
	sudo aptitude upgrade
	# echo "---Apt autoremove------------------------------------------------------------------------------------------------------"
	# sudo apt autoremove
	echo "--- Flatpak update --------------------------------------------------------------------------------------------------------"
	flatpak update
	echo "--- Flatpak clean ---------------------------------------------------------------------------------------------------------"
	flatpak uninstall --unused --delete-data
	echo "------------------------------------------------- Maintain done -----------------------------------------------------------"
}

## Obsidian Note Sync
function notes {
	cd ~/Desktop/Notes/sync
	git pull
	git add .
	git commit -m"$(date '+%F') backup"
	git push
	exit
}

# Configs
export KITTY_CONFIG_DIRECTORY="~/.config/kitty"
export LANG=en_US.UTF-8
export STARSHIP_CONFIG=~/.files/starship/.config/starship/pure.toml
