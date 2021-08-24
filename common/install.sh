#Choose user bootanimation
ui_print "   ***********************************"
ui_print "        Choose your Bootanimation     "
ui_print ""
ui_print "     Vol [+] = dark, Vol [-] = light  "
ui_print "   ***********************************"
if $VKSEL; then
  theme="-dark"
  ui_print ""
  ui_print "Dark bootanimation selected"
  ui_print ""
else
  theme=""
  ui_print ""
  ui_print "light bootanimation selected"
  ui_print ""
fi

ui_print "   ****************************************************"
ui_print "                  Choose The resolution                "
ui_print "    better to choose the same resolution as your phone "
ui_print ""
ui_print "      Vol [+] = 1080p, Vol [-] = next(720p / 1440p)    "
ui_print "   ****************************************************"
if $VKSEL; then
  reso="1080"
  ui_print ""
  ui_print "    1080 selected"
  ui_print ""
else
  ui_print ""
  ui_print "               Vol [+] = 720p, Vol [-] = 1440p "
  ui_print "   ****************************************************"
  if $VKSEL; then
    reso="720"
    ui_print ""
    ui_print "    720 selected"
    ui_print ""
  else
    reso="1440"
    ui_print ""
    ui_print "    1440 selected"
    ui_print ""
  fi
fi

chmod 0755 $MODPATH/curl

#Download Bootaniamation
src_link="https://raw.githubusercontent.com/MrMissx/bootanimation/master/bootanimation"
DLINK="$src_link""$theme"_"$reso".zip
config="bootanimation${theme}_${reso}.zip"
ui_print "- Downloading ${config}"
# ui_print $DLINK
($MODPATH/curl -f -k -o $MODPATH/bootanimation.zip $DLINK) || abort "   Download failed!"
ui_print "- Done..."
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

# is_mounted script thanks to (https://github.com/skittles9823)
if [ -d /oem/media ]; then
      is_mounted " /oem" || mount /oem
      is_mounted_rw " /oem" || mount_rw /oem
      is_mounted " /oem/media" || mount /oem/media
      is_mounted_rw " /oem/media" || mount_rw /oem/media
      mv /oem/media/bootanimation.zip /oem/media/bootanimation/bootanimation.zip
      cp_ch $MODPATH/bootanimation.zip /oem/media
fi

#Andoird 10 Multiple bootanimation support script:
for i in /system/media/*bootanimation*; do
    cp_ch $MODPATH/bootanimation.zip $MODPATH/$i
  if [ -f /system/media/bootanimation-dark.zip ]; then
    cp_ch $MODPATH/bootanimation.zip $MODPATH/system/media/bootanimation-dark.zip
  fi
done

for d in /system/product/media/*bootanimation*; do
  cp_ch $MODPATH/bootanimation.zip $MODPATH/$d
  if [ -f /system/product/media/bootanimation-dark.zip ]; then
    cp_ch $MODPATH/bootanimation.zip $MODPATH/system/product/media/bootanimation-dark.zip
  fi
done

ui_print ""
ui_print "Bootanimation Installation complete"
ui_print "If you want to change beetween dark or light"
ui_print "You can just reflash this module :)"