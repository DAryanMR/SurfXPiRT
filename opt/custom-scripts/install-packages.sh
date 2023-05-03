#! /bin/sh

####################################################################################
echo "Upgrading packages to fulfill unmet dependencies:::"
echo ""
echo ""
apt update
apt upgrade -y
#####################
## Updating apt-get and installing necessary packages
apt-get update
apt-get -y upgrade
echo ""
echo ""
echo "Successfully upgraded bookworm packages! Now installing new packages.."
#####################
echo ""
echo ""
echo "Started query for packages...."
echo ""
echo ""
apt-get -y install arandr *pulseaudio* xserver-xorg-input-libinput libinput-bin libinput-dev xinput xinput-calibrator xcompmgr ntp net-tools wireless-tools rfkill build-essential cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev curl vlc python3-vlc libblas-dev libopenblas-dev python3-pil.imagetk xserver-xorg xinit x11-utils x11-touchscreen-calibrator xserver-xorg-input-evdev xscreensaver xscreensaver-gl-extra xscreensaver-data-extra task-lxde-desktop blueman* software-properties-common libavcodec-* alsa-utils libgtk-3-dev ffmpeg libglvnd0 xvkbd onboard pm-utils python3-tk chromium xfce4-power-manager libgles2-mesa-dev libxcb-randr0-dev libxrandr-dev libxcb-xinerama0-dev libxinerama-dev libxcursor-dev libxcb-cursor-dev libxkbcommon-dev xutils-dev xutils-dev libpthread-stubs0-dev libpciaccess-dev libffi-dev x11proto-xext-dev libxcb1-dev libxcb-*dev libssl-dev libgnutls28-dev x11proto-dri2-dev libx11-dev libxcb-glx0-dev libx11-xcb-dev libxext-dev libxdamage-dev libxfixes-dev libva-dev x11proto-randr-dev x11proto-present-dev libelf-dev mesa-utils libvulkan-dev libvulkan1 libassimp-dev libdrm-dev libxshmfence-dev libxxf86vm-dev libunwind-dev libwayland-dev wayland-protocols libwayland-egl-backend-dev valgrind libzstd-dev vulkan-tools git build-essential bison flex ninja-build python3-mako python3-pip cmake g++ make build-essential git dkms
echo ""
echo ""
echo "Packages installed!"
#####################
echo "Purging brltty & firefox...."
echo ""
echo ""
# Purge unnecessary packages
apt-get -y purge brltty *firefox* --autoremove
echo ""
####################################################################################
## Setup lightdm-gtk-greeter
# Remove previous lightdm config files
echo "Removing default lightdm configs.."
rm -rf /etc/lightdm/lightdm.conf
rm -rf /etc/lightdm/lightdm-gtk-greeter.conf
#####################
# Copying adjusted config files
echo "Copying modified lightdm configs.."
cp /boot/firmware/opt/lightdm.conf /etc/lightdm
cp /boot/firmware/opt/lightdm-gtk-greeter.conf /etc/lightdm
#####################
echo "Lightdm configured, autologin set to user 'pi' "
echo ""
echo ""
####################################################################################
#####################
# Move opt-post-clone to /boot
mv /boot/firmware/opt/opt-post-clone/ /boot/
# It'll be used later as the updated opt
#####################
# Copying daisy.mp4 to test if vlc works
echo "Copying daisy.mp4 for video playback test"
mkdir -p /home/pi/Videos && cp /boot/firmware/opt/videos/daisy.mp4 /home/pi/Videos
#####################
# Copying rt-wifi-cli.desktop to /usr/share/applications
echo "Copying PiRT Wifi Client desktop files"
cp /boot/firmware/opt/rt-wifi-cli.desktop /usr/share/applications
# Making it executable
chmod +x /usr/share/applications/rt-wifi-cli.desktop
#####################
echo "Getting rights to execute PiRT-Wifi-Client without password"
# Removing previous sudoers
rm -rf /etc/sudoers
# Copying modified /etc/sudoers to run the wifi client without password
cp /boot/firmware/opt/sudoers /etc/sudoers
chmod +x /etc/sudoers
#####################
# Copying chromium-lightweight.desktop to /usr/share/applications
echo "Copying Chromium Lightweight desktop files"
cp /boot/firmware/opt/chromium-lightweight.desktop /usr/share/applications
# Making it executable
chmod +x /usr/share/applications/chromium-lightweight.desktop
#####################
# Copying chromium-lightweight script to /usr/local/bin/
echo "Copying Chromium Lightweight script"
cp /boot/firmware/opt/chromium-lightweight /usr/local/bin/
# exec rights
# Now you can run  ->  chromium-lightweight  <- from anywhere in the terminal to launch this script
chmod +x /usr/local/bin/chromium-lightweight
#####################
####################################################################################
# Copying Xcompmgr desktop entry to /etc/xdg/autostart/
echo "Copying Xcompmgr desktop files"
cp /boot/firmware/opt/Xcompmgr.desktop /etc/xdg/autostart/
# Making it executable
chmod +x /etc/xdg/autostart/Xcompmgr.desktop
####################################################################################
echo "Copying standalone apps to Desktop"
# Making a desktop dir to store
# miscellaneous standalone apps like these
mkdir -p /home/pi/Desktop/standalone-apps
######################
# Copying desktop apps
cp /usr/share/applications/rt-wifi-cli.desktop /home/pi/Desktop/standalone-apps/
cp /usr/share/applications/chromium-lightweight.desktop /home/pi/Desktop/standalone-apps/
######################
# Making all desktop apps executable
chmod +x /home/pi/Desktop/standalone-apps/*.desktop
######################
####################################################################################
echo "Copying ARandr display orientations"
mkdir -p /home/pi/.screenlayout
cp /boot/firmware/opt/standalone-landscape.sh /home/pi/.screenlayout/
cp /boot/firmware/opt/standalone-portrait.sh /home/pi/.screenlayout/
chmod +x /home/pi/.screenlayout/*.sh
####################################################################################
# Copy wpa_supplicant.service to /etc/systemd/system/
echo "Copying wpa_supplicant service"
cp /boot/firmware/opt/wpa_supplicant.service /etc/systemd/system/
####################################################################################
# Disable rc-local service
echo "Disabling rc-local.service..."
systemctl disable rc-local.service
####################################################################################
######################
# Enable startup services
#####################
# Move load-drivers-no-wifi.sh to /etc
mv /boot/firmware/opt/load-drivers-no-wifi.sh /etc
chmod +x /etc/load-drivers-no-wifi.sh
#####################
# Move clone-disk-par.sh to /etc
mv /boot/firmware/opt/clone-disk-par.sh /etc
chmod +x /etc/clone-disk-par.sh
#####################
#####################
# Copy my-rc-local.service to /etc/systemd/system/
cp /boot/firmware/opt/my-rc-local.service /etc/systemd/system/
######################
# Copy on-start.sh to /usr/local/bin/  and make it executable
cp /boot/firmware/opt/custom-scripts/on-start.sh /usr/local/bin/
chmod +x /usr/local/bin/on-start.sh
######################
#### Final choice of auto-connect for now ####
# Copy custom rc-local.sh to /etc/
echo "Setting up auto-connect script"
cp /boot/firmware/opt/rc-local.sh /etc/
chmod +x /etc/rc-local.sh
######################
# Reload system daemons
echo "Reloading system daemons"
systemctl daemon-reload
######################
# Enable wpa_sup service
echo "Enabling wpa_supplicant service"
systemctl enable wpa_supplicant.service
######################
# Enable custom rc-local
echo "Enabling autoloading services"
systemctl enable my-rc-local.service
####################################################################################
echo ""
echo ""
echo "Packages installed and configured successfully.."
echo "Reboot now.. and install vulkan if this is the first time you're running this script.."
####################################################################################
exit 0
