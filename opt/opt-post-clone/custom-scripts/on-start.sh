#! /bin/sh -e

echo "CSS1: Loading Modules"
sh /etc/load-drivers-no-wifi.sh
echo ""
echo "CSS2: Network Attempt"
sh /etc/rc-local.sh

exit 0
