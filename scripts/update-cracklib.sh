#!/bin/bash
# Update cracklib dictionary
BASE_DIR=$(pwd)      
# Update cracklib dictionary from local wordlist
create-cracklib-dict $BASE_DIR/db/wordlists/combined-wordlist.txt > /usr/share/dict/cracklib-small
      
# Log update
echo "$(date): Cracklib dictionary updated" >> /var/log/cracklib-update.log