alias mne="maintain | tee -a maintain.log && notify-send 'Maintain Complete' && exit" # Maintain and exit
alias mic_g='amixer get Capture | grep ": Capture.*\[" | sed "s/.*\[//" | uniq | sed "s/\]//"'
alias mic='amixer set Capture toggle 1> /dev/null && echo "Mic Status: $(mic_g)"'
alias kittup="curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin launch=n" # Update kitty
alias sai="sudo aptitude install"                                                            # apt update
alias python="python3"
alias code="codium"
alias vim="nvim"

## cli
alias glt="git log --oneline --graph"                  # Git commit graph
alias lg="lazygit"                                     # Lazygit
alias rm="trash-put"                                   # Delete
alias e="vim"                                          # Editor
alias mnte="sudo mount /dev/nvme0n1p5 /mnt/e"          # Mount E drive
alias mntee="sudo mount /dev/nvme0n1p5 /mnt/e && exit" # Mount E drive and exit
alias umnte="sudo umount /mnt/e"                       # Unmount E drive
alias mntc="sudo mount /dev/nvme0n1p3 /mnt/c"          # Mount C drive
alias mntce="sudo mount /dev/nvme0n1p3 /mnt/c && exit" # Mount C drive and exit
alias umntc="sudo umount /mnt/c"                       # Unmount C drive
alias rofi="rofi -normal-window -steal-focus"
alias powermenu="applet -r powermenu"

## movement
alias ..="cd .."
alias ...="cd ../.."
alias Z="z -I"

## work
alias xilset="source /tools/Xilinx/Vitis/2024.2/settings64.sh"
alias vivado="xilset && vivado"
alias openl="nix-shell --pure ~/openlane2/shell.nix"
alias cdl1="cd ~/Vitis_Libraries/database/L1"
alias cdl2="cd ~/Vitis_Libraries/database/L2"
alias cdl3="cd ~/Vitis_Libraries/database/L3"
alias rv32="export RISCV=/opt/riscv/riscv32"
alias rv64="export RISCV=/opt/riscv/riscv64 && export PATH=$PATH:/opt/riscv/riscv64/bin/:"
alias rvc="riscv64-unknown-elf-gcc"
alias rvr="spike --isa=RV32IMAC pk"

## Chips login
alias chips_ub="kitty +kitten ssh -X chips@chips_server_ub"
alias chips_ab="kitty +kitten ssh -X chips@chips_abadon"
alias chips_st="kitty +kitten ssh -X chips@chips_stolen"
alias cabin="kitty +kitten ssh -X jsp@cabin"
# alias chips_rh="kitty +kitten ssh -X CHIPS@chips_redhat_old"

alias run="make vivado TUTORIAL=1"
alias clean="make clean"

## functions
if [ -f "$HOME/.shortcuts.sh" ]; then
	. "$HOME/.shortcuts.sh"
fi
export PATH=$PATH:/opt/riscv/riscv32/bin/
