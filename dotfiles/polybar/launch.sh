#!/usr/bin/bash

##############
# OLD SCRIPT #
##############

#Terminate already running bar instances
#killall -q polybar

# launch polybar
#echo "---" | tee -a /tmp/toppolybar.log
#polybar example >> /tmp/toppolybar.log


##############
# NEW SCRIPT #
##############

killall -q polybar

if type "xrandr"; then
	for display in $(xrandr --query | grep " connected" | cut -d" " -f1); do
		MONITOR=$display polybar --reload example &
	done
else
	polybar --reload example &
fi