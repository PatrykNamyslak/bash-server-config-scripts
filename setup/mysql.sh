#!bin/bash

# Update the system
sh ./setup/update.sh

sudo apt install mysql-server -y
sudo systemctl start mysql.service


while : ; do
    stty -echo
    echo "Enter a password for your mysql root user:"
    read mysql_password
    echo "Re-enter the password for your mysql root user:"
    read mysql_password_confirmation
    stty echo
    if [ $mysql_password != $mysql_password_confirmation ]
    then
        echo "Passwords do not match"
        sleep 1
        clear
    else
        break
    fi
done

sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '$mysql_password';"
# mysql_secure_installation
echo "Would you like to create a non root user to access your database with all permissions?: Y|y/N|n"
read create_non_root_user
case "$create_non_root_user" in
    "Y"|"y")
    echo "What would you like to call this user? (Username):"
    read database_user_username
    while : ; do
        stty -echo
        echo "Enter a password for your mysql user:"
        read mysql_custom_user_password
        echo "Re-enter the password for your mysql user:"
        read mysql_custom_user_password_confirmation
        stty echo
        if [ $mysql_custom_user_password != $mysql_custom_user_password_confirmation ]
        then
            echo "Passwords do not match"
            sleep 1
            clear
        else
            sudo mysql -e "CREATE USER '$database_user_username'@'localhost' IDENTIFIED WITH caching_sha2_password BY '$mysql_custom_user_password';"
            # Set users permissions to essentially be a root user
            sudo mysql -e "GRANT ALL PRIVILEGES ON *.* TO '$database_user_username'@'localhost' WITH GRANT OPTION";
            clear
            break
        fi
    done
    ;;
esac

if [ -f ./data/export.sql ]; then
    # Import SQL Data
    mysql -u $database_user_username -p < ./data/export.sql
    echo "Databases Imported"
else
    echo "There is no file to import."
fi

