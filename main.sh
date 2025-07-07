#!bin/bash

echo "Choose an operation you want to execute: "
echo "0: Export data and prepare for migration to a new server"
echo "1: Install & Setup Apache Web Server"
echo "2: Install & Setup PhpMyAdmin"
echo "3: Install & Setup MySQL Sever"
echo "4: Install & Setup Certbot SSL Certificate Manager"
echo "5: Update and Upgrade packages (Recommended to run before any of the other options)"
echo "6: Setup & Install All of the above"
read stage

case "$stage" in
    1)
        sh ./setup/apache.sh
        ;;
    2)
        sh ./setup/phpmyadmin.sh
        ;;
    3)
        sh ./setup/mysql.sh
        ;;
    4)
        sh ./setup/certbot.sh
        ;;
    5)
        sh ./setup/update.sh
        ;;
    6)
        sh ./setup/update.sh
        sh ./setup/apache.sh
        sh ./setup/mysql.sh
        sh ./setup/phpmyadmin.sh
        sh ./setup/certbot.sh
        ;;
    0)
        sh export.sh
        ;;

esac


# Delete all files and configs stored in the data folder
echo "Would you like to perform a cleanup operation to remove all of your already imported export that was stored in ./data/ ?"
read runCleanUp

case "$runCleanUp" in
    Y|y)
        sudo rm -rf ./data/*
        mkdir -p ./data/apache/sites-available/
        touch ./data/apache/sites-available/VIRTUAL HOSTS WILL GO HERE
        touch ./data/apache/APACHE CONFIG WILL APPEAR HERE
        ;;
esac