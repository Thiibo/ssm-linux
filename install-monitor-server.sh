#!/bin/bash

suffix="[Monitor Server Install]"

# Install SMTP
echo $suffix Installing SMTP
chmod +x ./install-smtp.sh
sudo ./install-smtp.sh

# Add execute permission to scripts in scripts directory
echo $suffix Adding execute permission to scripts in the scripts directory...
for file in $(pwd)/scripts/*.sh
do
  chmod +x $file
done

# Set up start up script
(crontab -l ; echo "@reboot $(pwd)/scripts/startup.sh") | crontab -

echo $suffix Done!
