#!bin/bash


# Reset UFW to default settings
sudo ufw --force reset

# Set default policies
sudo ufw default deny incoming
sudo ufw default allow outgoing

# Allow SSH and SFTP
sudo ufw allow OpenSSH
sudo ufw allow 22

# Allow HTTP and HTTPS for Apache
sudo ufw allow "Apache Full"

# Deny FTP explicitly
sudo ufw deny ftp
sudo ufw deny 21

# Enable the firewall
sudo ufw enable