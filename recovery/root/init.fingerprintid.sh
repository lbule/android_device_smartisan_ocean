#!sbin/sh

#
# use ro.build.fingerprint,
# use ro.build.version.release and ro.build.version.security_patch,
# from system/build.prop instead of default.prop,
# for keymaster-3.0+
#
#

SYSTEM_TMP=/tmp/system_tmp

for i in $(seq 0 50)
do
  systempart=`find /dev/block -name system | grep "by-name/system" -m 1 2>/dev/null`
  [ -z "$systempart" ] || break
  usleep 100000
done
if [ -z "$systempart" ]; then
  setprop "twrp.fingerprintid.prop" "0"
  exit 1
fi

setprop "twrp.fingerprintid.system" "$systempart"

mkdir -p "$SYSTEM_TMP"
mount -t ext4 -o ro "$systempart" "$SYSTEM_TMP"
usleep 100

fingerprint=`cat "$SYSTEM_TMP/build.prop" /system/build.prop /default.prop 2>/dev/null | grep -F "ro.build.fingerprint=" -m 1 | cut -d'=' -f2`
RELEASE=`cat "$SYSTEM_TMP/build.prop" /system/build.prop /default.prop 2>/dev/null | grep -F "ro.build.version.release=" -m 1 | cut -d'=' -f2`
PATCH=`cat "$SYSTEM_TMP/build.prop" /system/build.prop /default.prop 2>/dev/null | grep -F "ro.build.version.security_patch=" -m 1 | cut -d'=' -f2`
#SDK=`cat "$SYSTEM_TMP/build.prop" /system/build.prop /default.prop 2>/dev/null | grep ro.build.version.sdk -m 1 | cut -d'=' -f2`

resetprop "ro.build.fingerprint" "$fingerprint"
resetprop "ro.build.version.release" "$RELEASE"
resetprop "ro.build.version.security_patch" "$PATCH"
#resetprop "ro.build.version.sdk" "$SDK"

setprop "twrp.fingerprintid.prop" "1"

umount "$SYSTEM_TMP"


exit 0




