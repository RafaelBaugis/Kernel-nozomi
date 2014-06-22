#!/sbin/sh
# *********************************************************************
# * Copyright 2011 (C) Sony Ericsson Mobile Communications AB.        *
# * Copyright 2012 (C) Sony Mobile Communications AB.                 *
# * All rights, including trade secret rights, reserved.              *
# *********************************************************************
#
# Modified for recovery by cray_Doze
#

VENDOR_ID=0FCE
PID_PREFIX=0

get_pid_prefix()
{
  case $1 in
    "mass_storage")
      PID_PREFIX=E
      ;;

    "mass_storage,adb")
      PID_PREFIX=6
      ;;

    "mtp")
      PID_PREFIX=0
      ;;

    "mtp,adb")
      PID_PREFIX=5
      ;;

    "mtp,cdrom")
      PID_PREFIX=4
      ;;

    "mtp,cdrom,adb")
      PID_PREFIX=4
# workaround for ICS framework. Don't enable ADB for PCC mode.
      USB_FUNCTION="mtp,cdrom"
      ;;

    "rndis")
      PID_PREFIX=7
      ;;

    "rndis,adb")
      PID_PREFIX=8
      ;;

    *)
      return 1
      ;;
  esac

  return 0
}

# Forcibly set the "mass_storage,adb" mode.
PID_SUFFIX_PROP=$(/sbin/getprop ro.usb.pid_suffix)
#USB_FUNCTION=$(/sbin/getprop sys.usb.config)
USB_FUNCTION="mass_storage,adb"

echo 0 > /sys/class/android_usb/android0/enable
echo ${VENDOR_ID} > /sys/class/android_usb/android0/idVendor

get_pid_prefix ${USB_FUNCTION}
if [ $? -eq 1 ] ; then
  exit 1
fi

PID=${PID_PREFIX}${PID_SUFFIX_PROP}

echo ${PID} > /sys/class/android_usb/android0/idProduct

echo ${USB_FUNCTION} > /sys/class/android_usb/android0/functions

echo 1 > /sys/class/android_usb/android0/enable


exit 0
