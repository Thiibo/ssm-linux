#!/bin/bash

LOG_FILE="${$1:='/var/log/auth.log'}" # Use first parameter as value, otherwise default to value
EMAIL="incoming@localhost"
SUBJECT="SSH Login Alert"

tail -n0 -F $LOG_FILE | while read LINE; do
    if echo "$LINE" | grep -q "sshd.*Accepted"; then
        echo -e "Subject:$SUBJECT\n\n$LINE" | /usr/sbin/sendmail -t $EMAIL
    fi
done
