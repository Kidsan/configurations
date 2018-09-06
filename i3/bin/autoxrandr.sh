#!/bin/bash

# Built in display
MONITOR=eDP1

function ActivateExternal {
	echo "Activating 2 external displays"
	xrandr --output HDMI1 --auto --output eDP1 --off
	xrandr --output DP1 --auto --right-of HDMI1
	MONITOR=DP1
}
function ActivateInternal {
	echo "Switching to built in display"
	xrandr --output HDMI1 --off --output DP1 --off --output eDP1 --auto
	MONITOR=eDP1
}

# check what is disconnected

function ExternalActive {
	[ $MONITOR = "DP1" ]
}
function ExternalConnected {
	! xrandr | grep "^DP1" | grep disconnected
}

#Run Check
while true
do
	if ! ExternalActive && ExternalConnected
	then
		ActivateExternal
	fi

	if ExternalActive && ! ExternalConnected
	then
		ActivateInternal
	fi

	sleep 1s
done


