#!/usr/bin/env bash

HOME_SSH="$HOME/.ssh"
AUTH_KEYS="$HOME/.ssh/authorized_keys"

# check to see if the home ssh directory exists
if [ ! -d "$HOME_SSH" ]; then
  echo "$HOME_SSH does not exist, creating..."
  mkdir "$HOME_SSH"
fi

# Check to see of an authorized kyes file exists
if [ ! -f "$AUTH_KEYS" ]; then
    echo "$AUTH_KEYS does not exist, creating..."
    touch "$AUTH_KEYS"
fi

for file in ./*.pub; do
    my_var=$(cat $file)
    if ! grep -q "$my_var" "$AUTH_KEYS"; then
        echo "Key for $file not found, adding..."
        cat $file >> $AUTH_KEYS
    else
        echo "Key for $file found in $AUTH_KEYS."
    fi
done