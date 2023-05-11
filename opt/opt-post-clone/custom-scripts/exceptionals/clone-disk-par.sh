#! /bin/sh

####################################################################################
# Check if script is being run with root privileges
if [ "$(id -u)" != "0" ]; then
    echo "Error: This script must be run as root"
    exit 1
fi
#####################
echo "This script will clone the contents of /dev/mmcblk1 to /dev/mmcblk0."
echo "Beginning process.."
#####################
echo "Cloning SD card to eMMC..."
dd if=/dev/mmcblk1 of=/dev/mmcblk0 status=progress
#####################
echo "Updating cmdline.txt..."
# Removing previous /mnt/d if any
rm -rf /mnt/d
# Make directory to mount the partitions
mkdir /mnt/d
echo "Created dir /mnt/d/"
# Mount boot partition
echo "Mounting /dev/mmcblk0p1 on /mnt/d/.."
mount /dev/mmcblk0p1 /mnt/d
# Remove previous cmdline
echo "Removing previous cmdline.txt"
rm -rf /mnt/d/cmdline.txt
# Copy updated cmdline
echo "Copying updated cmdline.txt to boot partition"
cp /boot/firmware/opt/cmdline.txt /mnt/d
#####################
# Removing & replacing curr_opt with post_opt
echo "Moving opt-post-clone to new boot partition"
mv /mnt/d/opt/opt-post-clone /mnt/d
rm -rf /mnt/d/opt
mv /mnt/d/opt-post-clone /mnt/d/opt
chmod -R +x /mnt/d/opt/
#####################
# Copy bootloader
echo "Copying sRT bootloader to boot partition"
cp -r /boot/firmware/opt/bootloader/* /mnt/d
#####################
# Unmount boot partition
echo "Unmounting /dev/mmcblk0p1"
umount /dev/mmcblk0p1
#####################
echo "Updating fstab..."
# Mount filesystem
echo "Mounting /dev/mmcblk0p2 on /mnt/d/" 
mount /dev/mmcblk0p2 /mnt/d
# Remove previous fstab
echo "Removing previous fstab from fs"
rm -rf /mnt/d/etc/fstab
# Copy updated fstab
echo "Copying updated fstab to fs"
cp /boot/firmware/opt/fstab /mnt/d/etc
#####################
# Copy updated rpi-set-sysconf
echo "Removing previous rpi-set-sysconf"
rm -rf /mnt/d/usr/local/sbin/rpi-set-sysconf
echo "Copying updated rpi-set-sysconf file..."
cp /boot/firmware/opt/rpi-set-sysconf /mnt/d/usr/local/sbin
chmod +x /mnt/d/usr/local/sbin/rpi-set-sysconf
#####################
# Copy updated sudoers to fs
rm -rf /mnt/d/etc/sudoers
cp /boot/firmware/opt/sudoers-new /mnt/d/etc/sudoers
#####################
# Unmount fs
echo "Unmounting /dev/mmcblk0p2 ..."
umount /dev/mmcblk0p2
# Resize fs 
echo "Create new mmcblk0p2 partition"
fdisk /dev/mmcblk0
echo "Checking for errors"
e2fsck -f /dev/mmcblk0p2
echo "Resizing filesystem"
resize2fs /dev/mmcblk0p2
echo ""
echo "Clone successful."
echo "Turn off device, remove SD card, and power it on normally. ;) "

exit 0
