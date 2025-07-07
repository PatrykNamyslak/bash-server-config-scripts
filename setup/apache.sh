#!bin/bash

# Update the system
sh update.sh

sudo apt install apache2 -y
sudo service apache2 start
sudo service apache2 enable
sudo a2dissite 000-default.conf
sudo rm /etc/apache2/sites-available/*
sudo systemctl restart apache2
a2enmod rewrite
sudo apt-get install php8.2
sudo cp ./assets/apache/apache.conf /etc/apache2/apache2.conf
sudo cp ./assets/apache/sites-available/ /etc/apache2/
sudo rm -rf /etc/apache2/*-le-ssl*
sudo sh fix-virtual-hosts.sh
sudo service apache2 reload
sudo service apache2 restart