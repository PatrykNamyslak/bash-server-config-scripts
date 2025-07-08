#!bin/bash

# Update the system
sh ./setup/update.sh
# Install and Enable apache
sudo apt install apache2 -y
sudo service apache2 start
sudo service apache2 enable

# Remove the default virtual hosts
sudo a2dissite 000-default.conf
sudo rm /etc/apache2/sites-available/*
sudo systemctl restart apache2

