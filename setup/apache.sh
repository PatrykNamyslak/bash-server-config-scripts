#!bin/bash

# Update the system
sh update.sh
# Install and Enable apache
sudo apt install apache2 -y
sudo service apache2 start
sudo service apache2 enable

# Remove the default virtual hosts
sudo a2dissite 000-default.conf
sudo rm /etc/apache2/sites-available/*
sudo systemctl restart apache2

a2enmod rewrite

# Install php 8.2 as that is what is needed for phpmyadmin
sudo apt-get install php8.2 -y

# Import apache data
sudo cp ./data/apache/apache.conf /etc/apache2/apache2.conf
sudo cp ./data/apache/sites-available/ /etc/apache2/
# Cleanup virtual hosts and remove any ssl certificate residue
sudo rm -rf /etc/apache2/*-le-ssl*
sudo sh ./setup/fix-virtual-hosts.sh
# Restart apache
sudo service apache2 reload
sudo service apache2 restart