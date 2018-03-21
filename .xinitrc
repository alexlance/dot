[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
xmodmap /home/alla/.Xmodmap

if [ -x /usr/bin/synclient ]; then
  synclient RightButtonAreaLeft=1
  synclient ClickFinger2=2
  synclient TapButton2=2
  # middle click with two fingers
  synclient ClickFinger2=2
  #synclient TapButton1=1 noooooo
  synclient TapButton2=2
  synclient TapAndDragGesture=0
  synclient SingleTapTimeout=300
  synclient PalmDetect=1
  synclient PalmMinWidth=40
  synclient HorizTwoFingerScroll=1
fi

if [ -x /home/alla/bin/xflux ]; then
  [ "$(pidof xflux)" ] || /home/alla/bin/xflux -l "37.8136" -g "144.9631" &
fi

xautolock -time 10 -locker xtrlock -corners 00+0 -cornerdelay 1 -cornerredelay 5 -secure &
exec ratpoison
