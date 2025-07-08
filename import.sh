#!bin/bash

# Import apache data
sudo mv ./data/apache/apache2.conf /etc/apache2/apache2.conf
sudo mv ./data/apache/sites-available/ /etc/apache2/
# srv data + motd and logon banenr
sudo mv ./data/websites/ /srv/
sudo mv ./data/commands/ /srv/
sudo mv ./data/archives/ /srv/
sudo mv ./data/files/ /srv/
sudo mv ./data/authorized_keys /home/itzaver/.ssh/authorized_keys
sudo mv ./data/.bashrc /home/itzaver/
sudo mv ./data/logon-banner.txt /srv/
sudo mv ./data/motd /etc/