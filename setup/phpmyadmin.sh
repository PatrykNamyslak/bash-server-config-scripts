#!bin/bash

# Update the system
sh ./setup/update.sh

sudo apt install phpmyadmin php-mbstring php-zip php-gd php-json php-curl -y

echo "Follow the entire green section in a new ssh tab and after you have done that press enter to continue in this window"
read temp


sudo phpenmod mbstring
sudo systemctl restart apache2