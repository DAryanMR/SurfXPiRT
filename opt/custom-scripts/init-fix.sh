#! /bin/bash

# Initial modifications (Resize fs, Update [fstab, hostname, hosts], create_user 'pi')
echo "executing init-fix.sh"
echo "Deleting and creating mmcblk1p2 (of atleast 8GB) to proceed installation"
# Resizing the filesystem 
# Delete and create new mmcblk1p2 using fdisk
echo "d
2
n
p
2
1048576

w" | fdisk /dev/mmcblk1
# Assuming that you have created the new partition
# Resize it using resize2fs
echo "Resizing filesystem.."
resize2fs /dev/mmcblk1p2

# Copying modified fstab to mount mmcblk1p1 and p2 as /boot/firmware & /
echo "Setting up fstab to mount mmcblk1"
cp -f /boot/firmware/opt/fstab-blk1 /etc/fstab
# Reloading System daemons
systemctl daemon-reload
# Mounting corrected paritions
echo "Mounting corrected partitions"
mount -a
echo "Newly mounted partitions are:"
cat /etc/fstab

# Copying modified hostname and hosts
echo "Setting up host"
cp -f /boot/firmware/opt/hostname /etc/hostname
cp -f /boot/firmware/opt/hosts /etc/hosts
echo "hostname set to:"
cat /etc/hostname

# Creating user 'pi'
echo "Creating user 'pi' "
echo "Enter details of user: "
adduser pi
# giving pi sudo privileges
echo "Giving pi sudo privileges"
usermod -aG sudo pi


echo "All pre-modifications are done"
sleep 2
clear

exit 0
