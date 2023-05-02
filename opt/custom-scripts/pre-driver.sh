#! /bin/sh

# Disable systemd-udev-settle
systemctl disable systemd-udev-settle.service

# Remove ifupdown
apt purge ifupdown -y --autoremove

# Remove previous interfaces and replace it with proper ones
rm -rf /etc/network/interfaces
rm -rf /etc/wpa_supplicant/wpa_supplicant.conf
cp /boot/firmware/opt/interfaces /etc/network/
cp /boot/firmware/opt/wpa_sup.conf /etc/wpa_supplicant/wpa_supplicant.conf

chmod +x /etc/network/interfaces
chmod +x /etc/wpa_supplicant/wpa_supplicant.conf
 
exit 0
