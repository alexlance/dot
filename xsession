xmodmap /home/alla/.Xmodmap

if [ -x /usr/bin/synclient ]; then
  synclient RightButtonAreaLeft=900 # lyra
  synclient ClickFinger2=2
  synclient TapButton2=2
  # middle click with two fingers
  synclient ClickFinger2=2
  synclient TapButton1=1 # noooooo... ?
  synclient TapButton2=2
  synclient TapAndDragGesture=0
  synclient SingleTapTimeout=300
  synclient PalmDetect=1
  synclient PalmMinWidth=40
  synclient HorizTwoFingerScroll=1
fi

if [ "${X_USE_VPN}" ]; then
  sudo -E /home/alla/bin/vpn &
fi

killall ssh-agent || true
ssh-agent -k || true

xrandr --newmode "2400x1600" 326.00  2400 2584 2840 3280  1600 1603 1613 1658 -hsync +vsync
xrandr --addmode eDP-1 "2400x1600"
xrandr --output eDP-1 --mode "2400x1600"

xautolock -time ${X_LOCK_TIME:-10} -locker xtrlock -secure &
exec ssh-agent -t 10h ratpoison
