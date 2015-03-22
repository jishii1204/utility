#!/bin/sh
#
#-----------------------------
# Output Disk Usage
#-----------------------------
#
# Set this script to crontab as below
# * * * * * cd ${SCRIPT_DIR}; ./output_disk_usage.sh > /dev/null 2>&1
#

FILE_DATE=`date +%Y%m%d`
CHECK_TIME=`date +%Y/%m/%d_%H:%M`

# Set these valiables
OUTPUT_DIR=xxx
TARGET_DISK_NAME=yyy

if [ ! -f ${OUTPUT_DIR}/disk_usage_${FILE_DATE}.txt ] ; then
    echo "Date  Size    Used    Avail   Use%" > ${OUTPUT_DIR}/disk_usage_${FILE_DATE}.txt
fi

df -Pm | grep "${TARGET_DISK_NAME}"  | awk -v time=${CHECK_TIME} 'BEGIN { OFS = "\t" } ; { print time, $2, $3, $4, $5 }' >> ${OUTPUT_DIR}/disk_usage_${FILE_DATE}.txt
