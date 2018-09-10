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

if [ "${X_USE_VPN}" ]; then
  sudo -E /home/alla/bin/vpn &
fi

xautolock -time ${X_LOCK_TIME:-10} -locker xtrlock -secure &
exec ratpoison
