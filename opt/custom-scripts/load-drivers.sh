#! /bin/sh

echo "executing load-drivers.sh"
# Run pre-driver script first
echo "Running pre-driver script"
sh /boot/firmware/opt/custom-scripts/pre-driver.sh

# Then run post-driver script
echo "Running post-driver script"
sh /boot/firmware/opt/custom-scripts/post-driver.sh

sleep 2
clear

exit 0
