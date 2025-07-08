#!bin/bash

apache_dir="etc/apache2"
websites_dir="/srv/websites/"
archives_dir="/srv/archives/"
personal_files_dir="/srv/files/"
saved_commands_dir="/srv/commands/"
data_dir="./data"

if [ ! -d $data_dir ]; then
    sh ./cleanup.sh
fi

# Get the username of the user that has the appropriate perms
echo "Enter your mysql username that has the required permissions to export all of the databases"
read mysql_username

# Move all virtual host configuration files from the apache folder into the export folder
sudo cp -R /$apache_dir/sites-available/ $data_dir/apache/
sudo cp -R /$apache_dir/apache2.conf $data_dir/apache/


# Copying bash config with aliases
sudo cp /home/itzaver/.bashrc $data_dir/

# Backup your mysql dbs
echo "Would you like to attempt an automatic export? Y/N"

read automatic_export

case "$automatic_export" in
    Y|y)
        mysqldump -u $mysql_username -p --all-databases > ./data/export.sql
        if [ -f ./data/export.sql ]; then
            echo "Databases successfully exported!"
        else
            echo "Database export Failed"
        fi
        ;;
    N|n)
        echo "Then go to your phpmyadmin page and export all database tables except the phpmyadmin database and place the .sql file in the data directory. Press the ENTER/RETURN key after you have done this"
        ;;
esac

# Export websites and other files in the srv directory
# Websites
if [ ! -d $websites_dir ]; then
    echo "Websites Directory does not exist - No export conducted"
else
    sudo cp -R $websites_dir $data_dir/
fi

# Archives
if [ ! -d $archives_dir ]; then
    echo "Archives Directory does not exist - No export conducted"
else
    sudo cp -R $archives_dir $data_dir/
fi

# Personal Files
if [ ! -d $personal_files_dir ]; then
    echo "Personal Files Directory does not exist - No export conducted"
else
    sudo cp -R $personal_files_dir $data_dir/
fi

# Saved Commands
if [ ! -d $saved_commands_dir ]; then
    echo "Saved Commands Directory does not exist - No export conducted"
else
    sudo cp -R $saved_commands_dir $data_dir/
fi


# SSH Keys & bash config
sudo cp /home/itzaver/.ssh/authorized_keys $data_dir/
sudo cp /home/itzaver/.bashrc $data_dir/

# Move the MOTD (Message of the day) / Login banner. Which is displayed at every login, but also backup the logon banner which is displayed before the users password is entered

# Login Banner
sudo cp /srv/logon-banner.txt $data_dir/

# Login attempt prompt/ banner
sudo cp /etc/motd $data_dir/

# Compress the data (Everything that is in that folder)

sudo tar -cvzf server-migration-snapshot.tar.gz -C $data_dir/*

if [ -f server-migration-snapshot.tar.gz ]; then
    echo "Export complete."
    echo "Please now copy this ($PWD) entire folder to your new server and run the import script"
    echo ""
    echo "Would you like to move the files using rsync?"
    read rsync_transfer
    case "$rsync_transfer" in
        Y|y)
            echo ""
            echo "Where would you like to send the files? (IP): "
            read destination_ip
            sudo rsync -avz -e "ssh" $PWD itzaver@$destination_ip:/srv/bash-server-config-scripts/
            ;;
    esac
fi