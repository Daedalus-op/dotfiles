if [ "$DESKTOP_SESSION" == "awesome" ]; then
	cd ~/.files
	git checkout clean 2>/dev/null
	cd
	copyq &
	nm-applet &
	xinput set-prop 12 'libinput Tapping Enabled' 1
	xinput set-prop 12 'libinput Natural Scrolling Enabled' 1
	xinput set-prop 12 "libinput Scroll Method Enabled" 1 0 0
	libinput-gestures-setup start
elif [[ "$DESKTOP_SESSION" == "ubuntu" ]]; then
	cd ~/.files
	git checkout master 2>/dev/null
	cd
fi
source .fehbg
