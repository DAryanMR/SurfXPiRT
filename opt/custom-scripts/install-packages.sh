#!/bin/bash

echo "executing install-packages.sh"
set -e

# Upgrade packages
echo "Upgrading packages..."
apt update && apt upgrade -y

# Install necessary packages
echo "Installing packages..."
apt install -y locales volumeicon-alsa libgl1-mesa-glx arandr pulseaudio pulseaudio-module-bluetooth xserver-xorg-input-libinput libinput-bin libinput-dev xinput xinput-calibrator xcompmgr ntp net-tools wireless-tools rfkill build-essential cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev curl vlc python3-vlc libblas-dev libopenblas-dev python3-pil.imagetk xserver-xorg xinit x11-utils x11-touchscreen-calibrator xserver-xorg-input-evdev xscreensaver xscreensaver-gl-extra xscreensaver-data-extra task-xfce-desktop blueman bluez software-properties-common libavcodec-* alsa-utils libgtk-3-dev ffmpeg libglvnd0 xvkbd onboard pm-utils python3-tk chromium xfce4-power-manager libgles2-mesa-dev libxcb-randr0-dev libxrandr-dev libxcb-xinerama0-dev libxinerama-dev libxcursor-dev libxcb-cursor-dev libxkbcommon-dev xutils-dev xutils-dev libpthread-stubs0-dev libpciaccess-dev libffi-dev x11proto-xext-dev libxcb1-dev libxcb-*dev libssl-dev libgnutls28-dev x11proto-dri2-dev libx11-dev libxcb-glx0-dev libx11-xcb-dev libxext-dev libxdamage-dev libxfixes-dev libva-dev x11proto-randr-dev x11proto-present-dev libelf-dev mesa-utils libvulkan-dev libvulkan1 libassimp-dev libdrm-dev libxshmfence-dev libxxf86vm-dev libunwind-dev libwayland-dev wayland-protocols libwayland-egl-backend-dev valgrind libzstd-dev vulkan-tools git build-essential bison flex ninja-build python3-mako python3-pip cmake g++ make build-essential git dkms

# Configure locales
echo "Configuring locales..."
dpkg-reconfigure locales

# Copy files and configurations
echo "Copying files and configurations..."

# Copy wallpapers to /usr/share/backgrounds
cp -r /boot/firmware/opt/images/backgrounds/* /usr/share/backgrounds/

# Copy standalone apps to /usr/share/applications
cp -r /boot/firmware/opt/d_apps/* /usr/share/applications/
chmod -R +x /usr/share/applications/

# # Copy standalone apps to Desktop
# mkdir -p /home/pi/Desktop/standalone-apps
# cp -r /boot/firmware/opt/d_apps/* /home/pi/Desktop/standalone-apps/
# chmod -R +x /home/pi/Desktop/standalone-apps/

# Copy executable scripts to /usr/local/bin/
cp -r /boot/firmware/opt/bin/* /usr/local/bin/

# Copy exceptional scripts to /etc
cp -r /boot/firmware/opt/custom-scripts/exceptionals/* /etc

# Copy autostart entries to /etc/xdg/autostart/
cp /boot/firmware/opt/autostart/* /etc/xdg/autostart/

# Copy display orientations
mkdir -p /home/pi/.screenlayout && cp -r /boot/firmware/opt/screen_layouts/* /home/pi/.screenlayout/
chmod -R +x /home/pi/.screenlayout/

# Copy daisy.mp4 for testing VLC
rm -rf /home/pi/Videos && mkdir -p /home/pi/Videos
cp /boot/firmware/opt/videos/daisy.mp4 /home/pi/Videos/

# Modify sudoers to execute PiRT-WiFi-Client without password
cp -f /boot/firmware/opt/sudoers /etc/sudoers
chmod 0440 /etc/sudoers

# Copy systemd services
cp -rf /boot/firmware/opt/systemd/* /etc/systemd/system/

# Copy adjusted raspi-firmware to fs
cp -f /boot/firmware/opt/raspi-firmware /etc/default/

# Disable unnecessary services
echo "Disabling unnecessary services..."
systemctl disable rc-local.service
systemctl mask systemd-binfmt.service

# Reload system daemons
echo "Reloading system daemons..."
systemctl daemon-reload

# Enable systemd-networkd service
echo "Enabling systemd-networkd service..."
systemctl enable systemd-networkd.service

# Enable wpa_supplicant service
echo "Enabling wpa_supplicant service..."
systemctl enable wpa_supplicant.service

# Enable custom rc-local
echo "Enabling my-rc-local service..."
systemctl enable my-rc-local.service

# Configure lightdm-gtk-greeter
echo "Configuring lightdm-gtk-greeter..."
cp -rf /boot/firmware/opt/lightdm/* /etc/lightdm/
echo "lightdm configured, autologin set to user 'pi' "

# Configure touchscreen
# copy xorg config
# .. (add here)
# prevent other processes from interfering 
# with the touchscreen
groupadd touchscreen
usermod -aG touchscreen pi
chgrp touchscreen /dev/input/event3
chmod g+r /dev/input/event3

echo "Setup complete!"
sleep 2
clear
