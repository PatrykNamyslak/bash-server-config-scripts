#!bin/bash

sudo apt update
sudo add-apt-repository ppa:ondrej/php
sudo apt update
sudo apt install php8.3 php8.3-cli php8.3-common php8.3-curl php8.3-mbstring php8.3-mysql php8.3-xml -y
sudo apt install libapache2-mod-php8.3
sudo systemctl restart apache2
sudo systemctl restart apache2