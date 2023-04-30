#! /bin/sh

# Check if script is being run with root privileges
if [ "$(id -u)" != "0" ]; then
    echo "Error: This script must be run as root"
    exit 1
fi

echo "This script will clone the contents of /dev/mmcblk1 to /dev/mmcblk0."
#read -p "Are you sure you want to continue? (y/n) " -n 1 -r
#echo ""
#if [[ ! $REPLY =~ ^[Yy]$ ]]
#then
#    echo "Aborted."
#    exit 1
#fi

echo "Cloning SD card to eMMC..."
dd if=/dev/mmcblk1 of=/dev/mmcblk0 status=progress

echo "Updating cmdline.txt..."
# Make directory to mount the partitions
mkdir /mnt/d

# Mount boot partition
mount /dev/mmcblk0p1 /mnt/d

# Remove previous cmdline
rm /mnt/d/cmdline.txt

# Copy updated cmdline
cp /boot/firmware/opt/cmdline.txt /mnt/d

# Copy bootloader
cp -r /boot/firmware/opt/bootloader/* /mnt/d

# Unmount boot partition
umount /dev/mmcblk0p1

echo "Updating fstab..."
# Mount filesystem
mount /dev/mmcblk0p2 /mnt/d

# Remove previous fstab
rm /mnt/d/etc/fstab

# Copy updated fstab
cp /boot/firmware/opt/fstab /mnt/d/etc

# Unmount fs
umount /dev/mmcblk0p2

echo "Clone successful."
echo "Turn off device, remove SD card, and power it on normally. ;) "

exit 0
