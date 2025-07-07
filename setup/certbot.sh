#!bin/bash

# Update the system
sh update.sh

sudo apt install certbot python3-certbot-apache
sudo systemctl reload apache2

# Start ssl certificate generation
sudo certbot -v