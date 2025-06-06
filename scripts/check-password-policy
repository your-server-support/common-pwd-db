#!/bin/bash
# Password policy enforcement script

# Check password age
check_password_age() {
    local user=$1
    local max_days=90
    local last_change=$(chage -l "$user" | grep "Last password change" | cut -d: -f2)
    local days_since_change=$(( ($(date +%s) - $(date -d "$last_change" +%s)) / 86400 ))
          
    if [ $days_since_change -gt $max_days ]; then
        echo "WARNING: Password for $user is older than $max_days days"
        return 1
    fi
      return 0
}

# Check password complexity
check_password_complexity() {
    local user=$1
    local passwd=$(getent shadow "$user" | cut -d: -f2)
        
    if [[ $passwd == *"!"* ]]; then
        echo "WARNING: Account $user is locked"
        return 1
    fi
        return 0
}

# Main function
main() {
    local users=$(getent passwd | cut -d: -f1)
    local failed=0
        
    for user in $users; do
        if ! check_password_age "$user"; then
            failed=1
        fi
            if ! check_password_complexity "$user"; then
                failed=1
            fi
    done
          
    exit $failed
 }

 main