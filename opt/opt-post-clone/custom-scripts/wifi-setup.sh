#! /bin/bash

# Check if script is being run with root privileges
if [ "$(id -u)" != "0" ]; then
    echo "Error: This script must be run as root"
    exit 1
fi

# Reopen interface
#ip link set mlan0 down
#ip link set mlan0 up

# Get Wi-Fi SSID and PSK from user
read -p "Enter Wi-Fi SSID: " ssid
read -p "Enter Wi-Fi PSK: " psk

# Kill previous wpa_supplicant and remove tmp files
echo "Killing previous wpa_supplicant"
kill -9 $(pidof wpa_supplicant) 
echo "Removing tmp files"
rm -rf /var/run/wpa_supplicant/

# Create a new block in wpa conf
network_block="network={
    ssid=\"$ssid\"
    scan_ssid=1
    key_mgmt=WPA-PSK
    psk=\"$psk\"
    priority=1
}";

# Add network block to the end of wpa conf
echo "$network_block" | tee -a /etc/wpa_supplicant/wpa_supplicant.conf > /dev/null;

# Reload wpa_sup
systemctl restart wpa_supplicant.service

# Unblock wifi if you have to
rfkill unblock wifi;

#ip route del default

# Generate WPA configuration file
#wpa_passphrase $ssid $psk > /etc/wpa_supplicant.conf;

# Start WPA supplicant
echo "Connecting to wifi.."
wpa_supplicant nl80211 -B -i mlan0 -c /etc/wpa_supplicant/wpa_supplicant.conf;

# Obtain IP address from DHCP server using dhclient
echo "Obtaining IP address.."
dhclient mlan0;

# Set default gateway (Requires Restart to work!)
gateway=$(ip route | awk '/default via/');
old_gateway=$(ip route | awk '/^default via/{print $3}');
if [ ! -z "$old_gateway" ]; then
    ip route del default;
    echo "Old default gateway $old_gateway deleted.";
fi
ip route add $gateway;
echo "Default gate set to $gateway for mlan0 interface."
ip route add default via $(ip route | awk '/default/ {print $3}') dev $(ip route | awk '/default/ {print $5}')

echo "Services modified."
echo ""
echo ""

echo "Wifi connected... "

exit 0
