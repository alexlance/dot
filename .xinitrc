xrdb -merge /home/alla/.Xresources 
xmodmap /home/alla/.Xmodmap
xrandr --dpi 100
<<<<<<< HEAD
xinput set-prop 10 273 0.5
xterm &
=======
>>>>>>> f4b82a8b568bbe08ea9afc0ce1a31a56ee990f93
xautolock -time 2 -locker xtrlock -corners 00+0 -cornerdelay 1 -cornerredelay 5 -secure &
xinput set-prop 15 238 0.5
exec ratpoison
