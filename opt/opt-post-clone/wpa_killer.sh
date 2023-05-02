#! /bin/sh

echo "Killing previous wpa_supplicant"
kill -9 $(pidof wpa_supplicant)
echo "Putting mlan0 down"
ip link set mlan0 down

exit 0
