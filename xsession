xmodmap -e 'remove lock = Caps_Lock'
xmodmap -e 'keysym Caps_Lock = Escape'
xmodmap -e 'clear mod4'

if [ -x /usr/bin/synclient ]; then
  synclient RightButtonAreaLeft=900  # y-coord of the touchpad that delineate left vs right-click
  synclient TapButton1=1             # a one finger TAP   = left click
  synclient TapButton2=2             # a two finger TAP   = middle click
  synclient ClickFinger2=2           # a two finger CLICK = middle click
  synclient TapAndDragGesture=0      # disable tap and drap
  synclient SingleTapTimeout=300     # single tap vs double tap time
  synclient PalmDetect=1             # prevent palm grazing the touchpad
  synclient PalmMinWidth=40          # how wide is a palm
  synclient HorizTwoFingerScroll=1   # scroll sideways with two fingers

  xrandr --newmode "2400x1600" 326.00  2400 2584 2840 3280  1600 1603 1613 1658 -hsync +vsync
  xrandr --addmode eDP-1 "2400x1600"
  xrandr --output eDP-1 --mode "2400x1600"
fi

killall ssh-agent || true
ssh-agent -k || true

xautolock -time ${X_LOCK_TIME:-10} -locker xtrlock -secure &
exec ssh-agent -t 10h ratpoison
