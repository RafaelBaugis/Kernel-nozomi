#!/sbin/sh
#
# @(#) postrecoveryboot.sh for Xperia GX/SX/AX/VL/Z ver. 1.1.0 2013.06.01
#
# Description:
#   A postrecoveryboot script that simple function with logging.
#
# Author:
#   cray_Doze
#
###########################################################################

# Constant definition
LOGPATH="/cache/chargemon"
LOGFILE="${LOGPATH}/postrecoveryboot.log"

# Environment variable definition
PATH="/sbin"; export PATH

# Function definition for logging
ECHOL(){
  _DATETIME=`date +"%Y%m%d %H%M%S"`
  echo "${_DATETIME}: $*" >> ${LOGFILE}
  return 0
}
EXECL(){
  _DATETIME=`date +"%Y%m%d %H%M%S"`
  echo "${_DATETIME}: $*" >> ${LOGFILE}
  $* 2>> ${LOGFILE}
  _RET=$?
  echo "${_DATETIME}: RET=${_RET}" >> ${LOGFILE}
  return ${_RET}
}

# Logfile rotation
if [ ! -d "${LOGPATH}" ];then
  mkdir ${LOGPATH}
  chown system.cache ${LOGPATH}
  chmod 770 ${LOGPATH}
else
  if [ -f ${LOGFILE} ];then
    mv ${LOGFILE} ${LOGFILE}.old
  fi
  touch ${LOGFILE}
  chmod 660 ${LOGFILE}
fi

# Start main routine
ECHOL "### postrecoveryboot start..."

# umount partitions.
ECHOL "### umount partitions..."
EXECL umount -l /data
EXECL umount -l /system

# setup zoneinfo
EXECL tar xf /zoneinfo.tar

# umount sdcard.
ECHOL "### umount internal-storage..."
SDCARD_MOUNTPOINT=`mount | grep -i "/dev/block/platform/msm_sdcc.1/by-name/SDCard" | awk '{print $3}'`
if [ "${SDCARD_MOUNTPOINT}" != "" ]; then
  EXECL umount -l ${SDCARD_MOUNTPOINT}
  EXECL cp -p /etc/recovery2.fstab /etc/recovery.fstab
else
  if [ -f /proc/mtd ]; then
    EXECL cp -p /etc/recovery4.fstab /etc/recovery.fstab
  elif [ "`cat /proc/partitions | grep mmcblk0p | tail -1 | awk '{print $4}'`" = "mmcblk0p15" ]; then
    EXECL cp -p /etc/recovery3.fstab /etc/recovery.fstab
  else
    EXECL cp -p /etc/recovery1.fstab /etc/recovery.fstab
  fi
fi


EXECL /sbin/setprop ctl.stop console

# Kill remaining processes under /system/bin
ECHOL "### kill remaining processes under /sytem/bin..."
for RUNNINGPRC in $(ps | grep /system/bin | grep -v grep | awk '{print $1}' )
do
  EXECL kill -9 ${RUNNINGPRC}
done

ECHOL "### postrecoveryboot end..."
