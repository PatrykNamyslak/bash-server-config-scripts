#!bin/bash

# Update the system
sh ./setup/update.sh

sudo apt install certbot python3-certbot-apache -y
sudo systemctl reload apache2

# Start ssl certificate generation
sudo certbot -v