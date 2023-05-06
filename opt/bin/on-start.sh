#! /bin/sh -e

# Load modules while startup
sh /etc/load-drivers-no-wifi.sh

# Attempt to connect to network
sh /etc/rc-local.sh

exit 0
