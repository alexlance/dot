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
  [ "$(pidof xflux)" ] || /home/alla/bin/xflux -l "37.813" -g "144.963" &
fi

if [ "${X_USE_VPN}" ]; then
  /home/alla/bin/vpn &
fi

xautolock -time ${X_LOCK_TIME:-10} -locker xtrlock \
  -corners 00+0 -cornerdelay 1 -cornerredelay 5 -secure \
  -notify 1 -notifier "ratpoison -c 'echo Locking soon'" &

exec ratpoison