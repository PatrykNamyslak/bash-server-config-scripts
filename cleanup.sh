#!bin/bash
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