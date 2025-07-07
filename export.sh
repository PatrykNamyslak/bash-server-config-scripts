#!bin/bash

apache_dir = "etc/apache2"

export_dir = "./export"


# Create the folder where the export will be held until compression commences
mkdir $export_dir


# Move all virtual host configuration files from the apache folder into the export folder
sudo cp -R /$apache_dir/sites-available/ $export_dir/

# Copying bash config with aliases

sudo cp /home/itzaver/.bashrc $export_dir/

echo "Now go to your phpmyadmin page and export all database tables except the phpmyadmin database. Click after you have done this"

read temp