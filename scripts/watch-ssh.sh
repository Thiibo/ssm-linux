#!/bin/bash

LOG_FILE="/var/log/auth.log" # Use first parameter as value, otherwise default to value
EMAIL="incoming@localhost"
SUBJECT="SSH Login Alert"

tail -n0 -F $LOG_FILE | while read LINE; do
    if echo "$LINE" | grep -q "sshd.*Accepted"; then
        echo -e "Subject:$SUBJECT\n\n$LINE" | ./send-mail -t $EMAIL
    fi
done
