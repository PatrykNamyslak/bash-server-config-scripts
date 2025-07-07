#!bin/bash

apache_dir = "etc/apache2"
websites_dir = "/srv/websites/"
archives_dir = "/srv/archives/"
personal_files_dir = "/srv/files/"

data_dir = "./data"


# Move all virtual host configuration files from the apache folder into the export folder
sudo cp -R /$apache_dir/sites-available/ $data_dir/apache/
sudo cp -R /$apache_dir/apache.conf $data_dir/apache/


# Copying bash config with aliases
sudo cp /home/itzaver/.bashrc $data_dir/

# Backup your mysql dbs
echo "Now go to your phpmyadmin page and export all database tables except the phpmyadmin database. Press the enter key after you have done this"

read temp

# Export websites and other files in the srv directory
# Websites
if [ ! -d $websites_dir ]; then
    echo "Websites Directory does not exist - No export conducted"
else
    cp -R $websites_dir $data_dir/
fi

# Archives
if [ ! -d $archives_dir ]; then
    echo "Archives Directory does not exist - No export conducted"
else
    cp -R $archives_dir $data_dir/
fi

# Files
if [ ! -d $personal_files_dir ]; then
    echo "Personal Files Directory does not exist - No export conducted"
else
    cp -R $personal_files_dir $data_dir/
fi

# SSH Keys & bash config
cp /home/itzaver/.ssh/authorized_keys $data_dir/
cp /home/itzaver/.bashrc $data_dir/

# Move the MOTD (Message of the day) / Login banner. Which is displayed at every login, but also backup the logon banner which is displayed before the users password is entered

# Login Banner
cp /srv/logon-banner.txt $data_dir/

# Login attempt prompt/ banner
cp /etc/motd $data_dir/

# Compress the data (Everything that is in that folder)
tar -cvzf server-migration-snapshot.tar.gz ./data/*