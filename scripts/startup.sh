#!/bin/bash

# Do stuff
echo [$(date)] [$(whoami)@$(hostname)] Server started. >> ~/server.log

./watch-shadow-file.sh &
./watch-ssh.sh &

# Send mail
recipient="incoming@localhost"
subject="Server startup script performed for $(hostname)"
body="We have performed the needed actions to make this server start."

echo "$body" | mail -s "$subject" "$recipient"
