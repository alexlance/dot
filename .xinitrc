xrdb -merge /home/alla/.Xresources
xmodmap /home/alla/.Xmodmap
xrandr --dpi 100
xinput set-prop 10 273 0.5
xterm &
xautolock -time 5 -locker xtrlock -corners 00+0 -cornerdelay 1 -cornerredelay 5 -secure &
xinput set-prop 15 238 0.5
dmesg -D # try to prevent network interface debug messages printing randomly in my terminal
exec ratpoison
