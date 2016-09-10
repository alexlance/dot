xrdb -merge /home/alla/.Xresources 
xmodmap /home/alla/.Xmodmap
xrandr --dpi 100
xinput set-prop 10 273 0.5
xterm &
exec ratpoison
