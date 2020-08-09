  
ui_print ""
ui_print "********************************************"
ui_print "*            Twice Bootanimation           *"
ui_print "********************************************"
ui_print "*                By Mr.Miss                *"
ui_print "********************************************"
ui_print "*        Thanks to @kvxrun for script      *"
ui_print "********************************************"
ui_print ""

#Bootanimation installation:
ui_print "Installing Bootanimation..."
  
#Mount functions, to monut /oem in sony devices. Thanks a ton to: (https://github.com/ironydelerium)

is_mounted_rw() {
  cat /proc/mounts | grep -q " `readlink -f $1` " | grep -q " rw," 2>/dev/null
  return $?
}

mount_rw() {
  mount -o remount,rw $1
  DID_MOUNT_RW=$1
}

unmount_rw() {
  if [ "x$DID_MOUNT_RW" = "x$1" ]; then
    mount -o remount,ro $1
  fi
}
# is_mounted script thanks to (https://github.com/skittles9823)
if [ -d /oem/media ]; then
      is_mounted " /oem" || mount /oem
      is_mounted_rw " /oem" || mount_rw /oem
      is_mounted " /oem/media" || mount /oem/media
      is_mounted_rw " /oem/media" || mount_rw /oem/media
      mv /oem/media/bootanimation.zip /oem/media/bootanimation/bootanimation.zip
      cp_ch $MODPATH/Bootanimation/bootanimation.zip /oem/media
fi

#Andoird 10 Multiple bootanimation support script:
for i in /system/media/*bootanimation*; do
    cp_ch $MODPATH/Bootanimation/bootanimation.zip $MODPATH/$i
  if [ -f /system/media/bootanimation-dark.zip ]; then
    cp_ch $MODPATH/Bootanimation/bootanimation.zip $MODPATH/system/media/bootanimation-dark.zip
  fi
done

for d in /system/product/media/*bootanimation*; do
  cp_ch $MODPATH/Bootanimation/bootanimation.zip $MODPATH/$d
  if [ -f /system/product/media/bootanimation-dark.zip ]; then
    cp_ch $MODPATH/Bootanimation/bootanimation.zip $MODPATH/system/product/media/bootanimation-dark.zip
  fi
done
ui_print ""
ui_print "Bootanimation Installation complete"