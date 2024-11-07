# starship
eval "$(starship init bash)"

# alias
## updates and installs
alias maintain="sudo apt update && sudo apt upgrade && sudo apt autoremove && flatpak update" # Maintain
alias mne="maintain && exit" # Maintain and exit
alias kittup="curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin launch=n" # Update kitty
alias sai="sudo apt install" # apt update
alias python="python3"

## cli
alias glt="git log --oneline --graph" # Git commit graph
alias lg="lazygit" # Lazygit
alias rm="trash-put" # Delete
alias e="vim" # Editor
alias mnte="sudo mount /dev/nvme0n1p5 /mnt/e" # Mount E drive
alias mntee="sudo mount /dev/nvme0n1p5 /mnt/e && exit" # Mount E drive and exit
alias umnte="sudo umount /mnt/e" # Unmount E drive
alias mntc="sudo mount /dev/nvme0n1p3 /mnt/c" # Mount C drive
alias mntce="sudo mount /dev/nvme0n1p3 /mnt/c && exit" # Mount C drive and exit
alias umntc="sudo umount /mnt/c" # Unmount C drive
alias rofi="rofi -normal-window -steal-focus"

## movement
alias ..="cd .."
alias ...="cd ../.."

## work
alias xilset=".  /tools/Xilinx/Vitis/2022.2/settings64.sh"
alias xrtset=". /opt/xilinx/xrt/setup.sh"
alias cdl1="cd ~/Vitis_Libraries/database/L1"
alias cdl2="cd ~/Vitis_Libraries/database/L2"
alias cdl3="cd ~/Vitis_Libraries/database/L3"

## rv 32 core sync
alias rvsv="rsync -av ~/play/play.srcs/sources_1/imports/rv32_core/src/ /mnt/files/Files/rv32_core/src/ && rsync -av ~/play/play.srcs/sources_1/imports/rv32_core/test/ /mnt/files/Files/rv32_core/test/" # rsync from vivado directory
alias rvsg="rsync -av /mnt/files/Files/rv32_core/src/ ~/play/play.srcs/sources_1/imports/rv32_core/src/ && rsync -av /mnt/files/Files/rv32_core/test/ ~/play/play.srcs/sources_1/imports/rv32_core/test/ " # rsync from github directory

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

## firefox skin switch - retired
# fskd="/home/xubundadu/.mozilla/firefox/fz2j9qcr.default-release/chrome/"
# function ffskin {
	# cd $fskd
	# git branch
	# read skin
	# git checkout $skin
	# exit
# }

export KITTY_CONFIG_DIRECTORY="~/.config/kitty"
export LANG=en_US.UTF-8
xilset
