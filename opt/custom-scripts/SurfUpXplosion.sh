#!/bin/bash

### Run this script using 'bash /boot/firmware/opt/SurfUpXplosion.sh' as root user 
### the first time you boot from usb

# Function to check the exit status of the previous command
check_status() {
  if [ $? -ne 0 ]; then
    echo "ERROR: The previous command failed with exit code $?. Exiting."
    exit 1
  fi
}

# Initial modifications (Resize fs, Update [fstab, hostname, hosts], create_user 'pi')
sh /boot/firmware/opt/custom-scripts/init-fix.sh
check_status

# Loading modules
sh /boot/firmware/opt/custom-scripts/load-drivers.sh
check_status

# Checking for existing wpa_supplicant configuration and attempt to connect to known netowork first
if [ ! -s /etc/wpa_supplicant/wpa_supplicant.conf ] || ! /boot/firmware/opt/bin/rc-local; then
  # if that fails
  # Setting up wifi
  sh /boot/firmware/opt/custom-scripts/wifi-setup.sh
  check_status
fi

# Installing packages including (XFCE, dependencies for mesa-vulkan, misc supplements)
sh /boot/firmware/opt/custom-scripts/install-packages.sh
check_status

# Installing Vulkan drivers (For HWA)
sh /boot/firmware/opt/custom-scripts/install-vulkan.sh
check_status

# Cloning Disk to eMMC (Who'd use a flash stick and sd card to fire it up everytime)
sh /boot/firmware/opt/custom-scripts/clone-disk.sh
check_status

exit 0