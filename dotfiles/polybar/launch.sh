killall -q polybar

if type "xrandr"; then
	for display in $(xrandr --query | grep " connected" | cut -d" " -f1); do
		MONITOR=$display polybar -c $HOME/.config/polybar/dark-config nord-top &
	done
else
	polybar -c $HOME/.config/polybar/dark-config nord-top &
fi
