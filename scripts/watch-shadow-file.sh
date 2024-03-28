#!/bin/bash

# Email configuration
recipient="incoming@localhost"
subject="Unauthorized Access to /etc/shadow"
body="Someone has attempted to access the /etc/shadow file on $(hostname) at $(date)."

# Monitor access to /etc/shadow
inotifywait -m -e access /etc/shadow | while read path action file; do
    # If access event detected, send email
    echo "$body" | mail -s "$subject" "$recipient"
done
