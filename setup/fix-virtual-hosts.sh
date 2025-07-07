#!/bin/bash

# Directory containing VirtualHost files
VHOST_DIR="/etc/apache2/sites-available"
BACKUP_DIR="/etc/apache2/sites-available/backup-$(date +%Y%m%d-%H%M%S)"

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit 1
fi

# Create backup directory
mkdir -p "$BACKUP_DIR"
if [ $? -ne 0 ]; then
    echo "Failed to create backup directory"
    exit 1
fi

# Process each .conf file in sites-available
for file in "$VHOST_DIR"/*.conf; do
    if [ -f "$file" ]; then
        echo "Processing $file..."
        
        # Create backup
        cp "$file" "$BACKUP_DIR/$(basename "$file").bak"
        if [ $? -ne 0 ]; then
            echo "Failed to backup $file"
            continue
        fi
        
        # Remove rewrite directives using sed
        sed -i '/^ *RewriteEngine/d
                /^ *RewriteCond/d
                /^ *RewriteRule/d' "$file"
        
        if [ $? -eq 0 ]; then
            echo "Successfully cleaned $file"
        else
            echo "Error processing $file"
        fi
    fi
done

echo "Cleanup complete. Backups stored in $BACKUP_DIR"
echo "Please verify changes and reload Apache with: sudo systemctl reload apache2"