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
  synclient AccelFactor=0.7          # FASTER MOUSE

  xrandr --newmode "2400x1600" 326.00  2400 2584 2840 3280  1600 1603 1613 1658 -hsync +vsync
  xrandr --addmode eDP-1 "2400x1600"
  xrandr --output eDP-1 --mode "2400x1600"
fi

# enable middle click emulation (click both mouse buttons at once)
# ps: fn+left click enables tap-to-click
# pps: solaar-cli pair & # logitech keyboard
if xinput --list --id-only "pointer:Logitech K830" >/dev/null; then
  xinput set-prop $(xinput --list --id-only "pointer:Logitech K830") "libinput Middle Emulation Enabled" 1
fi

# killall ssh-agent || true
# ssh-agent -k || true

# enable HCDP, so you can watch fucking tv content (eg 7plus.com.au) and other HDCP "protected" shit
# xrandr --output "DP-1" --set "Content Protection" "Enabled"
# xrandr --output "DP-1" --set "HDCP Content Type" "HDCP Type1"



# xautolock -time ${X_LOCK_TIME:-10} -locker xtrlock -secure &
xset -dpms
xset s off
xset r rate 200 40
#compton --backend glx --paint-on-overlay --vsync opengl-swc --daemon
#compton --backend glx --paint-on-overlay --daemon
#compton --daemon
compton --backend glx --paint-on-overlay --vsync opengl-swc &   # ALEX REMOVE THIS IF RATP DOESN"T START RIGHT - bbut you will get tearing when watching video/kayo
exec ssh-agent -t 12h ratpoison
