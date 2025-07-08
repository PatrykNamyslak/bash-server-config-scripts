#!bin/bash
# Delete all files and configs stored in the data folder

sudo rm -rf ./data/*
mkdir -p ./data/apache/sites-available/
touch ./data/apache/sites-available/VIRTUAL_HOSTS_WILL_GO_HERE
touch ./data/apache/APACHE_CONFIG_WILL_APPEAR_HERE
