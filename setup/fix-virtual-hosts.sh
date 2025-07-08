#!/bin/bash

# Directory containing VirtualHost files
VHOST_DIR="/etc/apache2/sites-available"

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit 1
fi

# Process each .conf file in sites-available
for file in "$VHOST_DIR"/*.conf; do
    if [ -f "$file" ]; then
        echo "Processing $file..."
        
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
echo "Virtual hosts have been fixed"