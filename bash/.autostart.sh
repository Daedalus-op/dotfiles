#! /usr/bin/bash

function mouse_start() {
	touchpad_no=$(xinput | grep -i touchpad | sed "s/.*id=//" | sed "s/\[.*//")
	xinput set-prop $touchpad_no 'libinput Tapping Enabled' 1
	xinput set-prop $touchpad_no 'libinput Natural Scrolling Enabled' 1
	xinput set-prop $touchpad_no "libinput Scroll Method Enabled" 1 0 0
	libinput-gestures-setup start
}
if [ "$DESKTOP_SESSION" == "awesome" ]; then
	cd ~/.files
	git checkout clean 2>/dev/null
	cd

	copyq &
	nm-applet &
	mouse_start
elif [[ "$DESKTOP_SESSION" == "ubuntu" ]]; then
	cd ~/.files
	git checkout master 2>/dev/null
	cd
fi
# source .fehbg
