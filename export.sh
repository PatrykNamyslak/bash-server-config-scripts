#!bin/bash

apache_dir = "etc/apache2"
websites_dir = "/srv/websites/"
archives_dir = "/srv/archives/"
personal_files_dir = "/srv/files/"

data_dir = "./data"

if [ ! -d $data_dir ]; then

fi


# Move all virtual host configuration files from the apache folder into the export folder
sudo cp -R /$apache_dir/sites-available/ $data_dir/apache/
sudo cp -R /$apache_dir/apache.conf $data_dir/apache/


# Copying bash config with aliases
sudo cp /home/itzaver/.bashrc $data_dir/

# Backup your mysql dbs
echo "Would you like to attempt an automatic export? Y/N"

read automatic_export

case "$automatic_export" in
    Y|y)
        mysqldump -u itzaver -p --all-databases > ./data/export.sql
        echo "Databases successfully exported!"
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

# Files
if [ ! -d $personal_files_dir ]; then
    echo "Personal Files Directory does not exist - No export conducted"
else
    sudo cp -R $personal_files_dir $data_dir/
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
sudo tar -cvzf server-migration-snapshot.tar.gz ./data/*

if [ -f server-migration-snapshot.tar.gz ]; then
    echo "Export complete."
    echo "Please now copy this ($PWD) entire folder to your new server and run the import script"
fi