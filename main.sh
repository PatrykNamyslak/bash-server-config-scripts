#!bin/bash

echo "Choose an operation you want to execute: "
echo "0: Export data and prepare for migration to a new server"
echo "1: Install & Setup Apache Web Server + PHP8.2"
echo "2: Install & Setup PhpMyAdmin"
echo "3: Install & Setup MySQL Sever :: Requires a file called export.sql file in the data archive."
echo "4: Install & Setup Certbot SSL Certificate Manager :: Requires apache to already be installed on the target system"
echo "5: Update and Upgrade packages (Recommended to run before any of the other options)"
echo "6: Import exported Data, setup & install all of the above"
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
        sh ./import.sh
        sh ./setup/firewall.sh
        sudo rm -rf ./server-migration-snapshot.tar.gz
        ;;
    0)
        sh export.sh
        exit 0
        ;;

esac

echo "Would you like to perform a cleanup operation to remove all of your already imported export that was stored in ./data/ ?"
read runCleanUp
case "$runCleanUp" in
    Y|y)
        sh cleanup.sh
        ;;
esac


echo "Would you like to restart? (Recommended)"
read restart_ans

case "$restart_ans" in
    Y|y)
        sudo reboot
        ;;
    N|n)
        echo "Okay, You are done!"
        sleep 2
        clear
        ;;
esac