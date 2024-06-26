#!/bin/bash

# Define the email details
recipient="recipient@example.com"
subject="Notification from Server Monitoring"
body="This is a notification from the server monitoring script."

# Define the SMTP servers
smtp_servers=("smtp1.example.com" "smtp2.example.com")
smtp_port="587"  # Update port number if needed
smtp_username="your_username"
smtp_password="your_password"

# Function to send email using specified SMTP server
send_email() {
    local server="$1"
    local username="$2"
    local password="$3"

    echo "Sending email through $server..."
    if echo "$body" | mailx -s "$subject" -S smtp="$server":"$smtp_port" -S smtp-use-starttls -S smtp-auth=login -S smtp-auth-user="$username" -S smtp-auth-password="$password" "$recipient"; then
        echo "Email sent successfully through $server"
        return 0
    else
        echo "Failed to send email through $server"
        return 1
    fi
}

# Attempt to send email through each SMTP server in round-robin fashion
for ((i = 0; i < ${#smtp_servers[@]}; i++)); do
    if send_email "${smtp_servers[i]}" "$smtp_username" "$smtp_password"; then
        exit 0
    fi
done

# If all servers fail, log the failure
echo "Failed to send email through all SMTP servers." >> /var/log/send_mail_errors.log

