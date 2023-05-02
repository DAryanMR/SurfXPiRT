#! /bin/bash

# Unblock wifi
rfkill unblock wifi

# Run rt-wifi-client
python3 /boot/opt/custom-scripts/rt-wifi-cli.py

exit 0
