#!/bin/bash

suffix="[SMTP Install]"

# Install packages
echo $suffix Installing packages...
sudo DEBIAN_FRONTEND=noninteractive apt-get -yq install mailutils

# Domain and hostname configurations
echo $suffix Configuring hostname and domain...
sudo postconf -e "mydomain=$(hostname).localdomain"
sudo postconf -e "mydestination=\$myhostname, $(hostname), localhost.localdomain, , localhost"
sudo postconf -e "myhostname=$(hostname).localdomain"

# Configure loopback-only
echo $suffix Configuring loopback-only...
sudo postconf -e "inet_interfaces=loopback-only"

# Encryption settings
echo $suffix Generating certificate...
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/postfix-selfsigned.key -out /etc/ssl/certs/postfix-selfsigned.crt -subj "/CN=$(hostname).localdomain/O=Howest/C=BE"
sudo postconf -e "smtpd_tls_cert_file=/etc/ssl/certs/postfix-selfsigned.crt"
sudo postconf -e "smtpd_tls_key_file=/etc/ssl/private/postfix-selfsigned.key"

# Create user
echo $suffix Creating user "incoming"...
sudo useradd incoming
