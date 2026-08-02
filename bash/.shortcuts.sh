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

function inc {
  local INC_FPGA_DIR="$HOME/Documents/Incore/FPGA"
  local SSH_CMD="kitty +kitten ssh"
  local INCORE_DIR5="$HOME/Documents/Incore/remote5"
  case "$1" in
  "4" | "5")
    $SSH_CMD -X -C pranav@incore$1
    ;;
  "status")
    watch sudo zerotier-cli info
    ;;
  "restart")
    sudo systemctl restart zerotier-one.service
    ;;
  "fs")
    export INCORE_DIR="$HOME/Documents/Incore/remote"
    case "$2" in
    "4" | "5")
      sshfs pranav@incore$2:/scratch1/pranav/shared $INCORE_DIR$2 -o follow_symlinks
      cd $INCORE_DIR$2
      ;;
    "wfh")
      export INCORE_DIR="$HOME/Documents/Incore/remote"
      case "$3" in
      "4" | "5")
        sshfs pranav@incore$3_wfh:/scratch1/pranav/shared $INCORE_DIR$3 -o follow_symlinks
        cd $INCORE_DIR$3
        ;;
      *)
        echo "Invalid option $3"
        inc help
        ;;
      esac
      ;;
    *)
      echo "Invalid option $2"
      inc help
      ;;
    esac
    ;;
  "fsq")
    export INCORE_DIR="$HOME/Documents/Incore/remote"
    case "$2" in
    "4" | "5")
      umount $INCORE_DIR$2
      ;;
    *)
      echo "Invalid option $2"
      inc help
      ;;
    esac
    ;;
  "wfh")
    case "$2" in
    "4" | "5")
      $SSH_CMD -C pranav@incore$2_wfh
      ;;
    *)
      echo "Invalid option $2"
      inc help
      ;;
    esac
    ;;
  "edit")
    echo "$1 $2 $3 $4"
    case "$2" in
    "4" | "5")
      $EDITOR scp://pranav@incore$2/$3
      ;;
    "wfh")
      case "$3" in
      "4" | "5")
        $EDITOR scp://pranav@incore$3_wfh/$4
        ;;
      *)
        echo "Invalid option $3"
        inc help
        ;;
      esac
      ;;
    *)
      echo "Invalid option $2"
      inc help
      ;;
    esac
    ;;
  "fpga")
    inc uart
    inc jlink
    ;;
  "uart")
    # gtkterm -p /dev/ttyUSB0 -s 625000 -e &
    gtkterm -c riscv &
    ;;
  "gdb")
    case "$2" in
    # set {int}0x70008000 = 0x1
    "all")
      cd "$INCORE_DIR5/sw"
      for f in */*.riscv; do
        echo "================================================="
        echo "Running GDB for: $f"
        echo "================================================="
        riscv64-unknown-elf-gdb -x $INC_FPGA_DIR/riscv_conf.gdb -ex "set confirm off" -ex "set {int}0x70008000 = 0x1" -ex "file $f" -ex "load" -ex "c" -ex "q"
      done
      ;;
    "run")
      riscv64-unknown-elf-gdb -x $INC_FPGA_DIR/riscv_conf.gdb -ex "set confirm off" -ex "file $3" -ex "load" -ex "c" -ex "q"
      ;;
    "rdir")
      cd "$3"
      for f in *.riscv; do
        echo "================================================="
        echo "Running GDB for: $f"
        echo "================================================="
        riscv64-unknown-elf-gdb -x $INC_FPGA_DIR/riscv_conf.gdb -ex "set confirm off" -ex "set {int}0x70008000 = 0x1" -ex "file $f" -ex "load" -ex "c" -ex "q"
      done
      ;;
    *)
      cd "$INCORE_DIR5/sw"
      riscv64-unknown-elf-gdb -x $INC_FPGA_DIR/riscv_conf.gdb
      ;;
    esac
    ;;
  "ocd")
    openocd -f $INC_FPGA_DIR/ocd_fpga_genesys.cfg
    ;;
  "jlink")
    openocd -f $INC_FPGA_DIR/jlink_fpga_genesys.cfg
    ;;
  "help")
    echo ""
    echo "Incore Helper =============================================="
    echo ""
    echo "Soc Helper Available Commands:"
    echo "	inc              4/5       - connect via local ssh"
    echo "	inc wfh          4/5       - work from home"
    echo "	inc fs  [wfh]    4/5       - mount shared file system"
    echo "	inc fsq          4/5       - quit shared file system"
    echo "	inc status                 - vpn status"
    echo "	inc restart                - vpn resart"
    echo "	inc edit [wfh] 4/5 <file>  - edit a remote file"
    echo "	inc fpga                   - openocd and gtkterm with genesys"
    echo "	inc uart                   - gtkterm with riscv profile"
    echo "	inc ocd                    - openocd with genesys"
    echo "	inc jlink                  - jlink with genesys"
    echo "	inc gdb [option]           - riscv gdb"
    echo "	  Available options"
    echo "	    all              - Run all elfs in sw directory"
    echo "	    rdir <dir>       - Run all elfs in the <dir> directory"
    echo "	    run <file.riscv> - Run specific elf"
    echo ""
    ;;
  *)
    echo "Invalid option $1"
    inc help
    ;;
  esac
}

# Configs
export KITTY_CONFIG_DIRECTORY="~/.config/kitty"
export LANG=en_US.UTF-8
export STARSHIP_CONFIG=~/.files/starship/.config/starship/pure.toml
# setxkbmap -option caps:escape
