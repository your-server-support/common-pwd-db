#!/bin/bash
BASE_DIR=$(pwd)
# Create temporary directory
TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR"

# Download wordlists
echo "Downloading wordlists..."
wget -q https://gitlab.com/kalilinux/packages/seclists/-/raw/kali/master/Passwords/Common-Credentials/10-million-password-list-top-1000000.txt -O /tmp/wordlist1.txt
wget -q https://gitlab.com/kalilinux/packages/seclists/-/raw/kali/master/Passwords/Common-Credentials/10k-most-common.txt -O /tmp/wordlist2.txt
wget -q https://gitlab.com/kalilinux/packages/seclists/-/blob/kali/master/Passwords/Common-Credentials/Pwdb_top-10000000.txt -O /tmp/wordlist3.txt
wget -q https://raw.githubusercontent.com/danielmiessler/SecLists/master/Passwords/Common-Credentials/xato-net-10-million-passwords.txt -O /tmp/wordlist4.txt

# Combine and sort wordlists
echo "Combining and sorting wordlists..."
cat /tmp/wordlist1.txt /tmp/wordlist2.txt /tmp/wordlist3.txt /tmp/wordlist4.txt | sort -u > /tmp/combined-wordlist.txt

# Create roles/password_policy/files directory if it doesn't exist
mkdir -p $BASE_DIR/db

# Move the combined wordlist to the role's files directory
echo "Moving combined wordlist to role's files directory..."

mv /tmp/combined-wordlist.txt $BASE_DIR/db/
cp $BASE_DIR/db/combined-wordlist.txt $BASE_DIR/ansible-roles/password-policy/files/


# Cleanup
cd - > /dev/null
rm -rf "$TEMP_DIR"

echo "Wordlist generation complete. The combined wordlist is now in $BASE_DIR/db/combined-wordlist.txt" 