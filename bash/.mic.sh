mic_g() {
	amixer get Capture | grep ": Capture.*\[" | sed "s/.*\[//" | uniq | sed "s/\]//"
}
amixer set Capture toggle 1>/dev/null
notify-send "Mic Toggle" "Mic Status: $(mic_g)"
