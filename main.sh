#!bin/bash

echo "Choose an operation you want to execute: "
echo "1: Install & Setup Apache Web Server"
echo "2: Install & Setup PhpMyAdmin"
echo "3: Install & Setup MySQL Sever"
echo "4: Install & Setup Certbot SSL Certificate Manager"
echo "5: Update and Upgrade packages (Recommended to run before any of the other options)"
echo "6: Setup & Install All of the above"
echo "7: Export data and prepare for migration to a new server"

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
    7)
        sh export.sh
        ;;

esac