#!/bin/bash
LOGFILE="/tmp/clamav-scan.log"
DATE=$(date)

echo "ClamAV scan started: $DATE" > $LOGFILE
clamdscan --multiscan --fdpass /home /var /etc >> $LOGFILE 2>&1
SCAN_EXIT=$?

if [ $SCAN_EXIT -ne 0 ]; then
    mail -s "ClamAV Alert - Issues Found" khoakomlem@gmail.com < "$LOGFILE"
else
    # echo "ClamAV scan completed successfully: $DATE" >> $LOGFILE
    # # Optionally email success too:
    mail -s "ClamAV Scan Complete - No Issues" khoakomlem@gmail.com < "$LOGFILE"
fi