#! /bin/sh -e

echo "Killing previous wpa_supplicant"
kill -9 $(pidof wpa_supplicant) 
echo "Removing tmp files"
rm -rf /var/run/wpa_supplicant/
echo "Making interface ready"
ip link set mlan0 down
rfkill unblock wifi
ip link set mlan0 up
echo "Connecting.."
wpa_supplicant nl80211 -B -i mlan0 -c /etc/wpa_supplicant/wpa_supplicant.conf
echo "Obtaining IP address"
dhclient mlan0
echo "Connection successfull"
# Set default gateway
gateway=$(ip route | awk '/default via/');
old_gateway=$(ip route | awk '/^default via/{print $3}');
if [ ! -z "$old_gateway" ]; then
    ip route del default;
    echo "Old default gateway $old_gateway deleted.";
fi
ip route add $gateway;
echo "Default gate set to $gateway for mlan0 interface."


exit 0
