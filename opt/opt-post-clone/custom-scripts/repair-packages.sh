#! /bin/sh 

echo "Upgrading packages to fulfill unmet dependencies:::";
echo ""
echo ""
apt update;
apt upgrade -y;

# Updating apt-get and installing necessary packages
apt-get update;
apt-get -y upgrade;
echo ""
echo ""
echo "Successfully upgraded bookworm packages! Now installing new packages..";

echo ""
echo ""

echo "Started query for packages...."
echo ""
echo ""
apt-get -y install xserver-xorg-input-libinput libinput-bin libinput-dev xinput xinput-calibrator xcompmgr ntp net-tools wireless-tools rfkill build-essential cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev curl vlc python3-vlc libblas-dev libopenblas-dev python3-pil.imagetk xserver-xorg xinit x11-utils x11-touchscreen-calibrator xserver-xorg-input-evdev xscreensaver xscreensaver-gl-extra xscreensaver-data-extra task-lxde-desktop blueman* software-properties-common libavcodec-* alsa-utils libgtk-3-dev ffmpeg libglvnd0 xvkbd onboard pm-utils python3-tk chromium xfce4-power-manager  libgles2-mesa-dev libxcb-randr0-dev libxrandr-dev libxcb-xinerama0-dev libxinerama-dev libxcursor-dev libxcb-cursor-dev libxkbcommon-dev xutils-dev xutils-dev libpthread-stubs0-dev libpciaccess-dev libffi-dev x11proto-xext-dev libxcb1-dev libxcb-*dev libssl-dev libgnutls28-dev x11proto-dri2-dev libx11-dev libxcb-glx0-dev libx11-xcb-dev libxext-dev libxdamage-dev libxfixes-dev libva-dev x11proto-randr-dev x11proto-present-dev libelf-dev mesa-utils libvulkan-dev libvulkan1 libassimp-dev libdrm-dev libxshmfence-dev libxxf86vm-dev libunwind-dev libwayland-dev wayland-protocols libwayland-egl-backend-dev valgrind libzstd-dev vulkan-tools git build-essential bison flex ninja-build python3-mako python3-pip cmake g++ make build-essential git dkms;
echo ""
echo ""
echo "Packages installed!"

echo "Purging brltty & firefox....";
echo ""
echo ""
# Purge unnecessary packages
apt-get -y purge brltty *firefox* --autoremove

echo ""

# Setup lightdm-gtk-greeter
# Remove previous lightdm config files
echo "Removing default lightdm configs.."
rm -rf /etc/lightdm/lightdm.conf;
rm -rf /etc/lightdm/lightdm-gtk-greeter.conf;

# Copying adjusted config files
echo "Copying modified lightdm configs.."
cp /boot/opt/lightdm.conf /etc/lightdm;
cp /boot/opt/lightdm-gtk-greeter.conf /etc/lightdm;

echo "Lightdm configured, autologin set to user 'pi' "
echo ""
echo ""

# Remove previous interfaces file and update it
echo "Reloading interfaces"
rm -rf /etc/network/interfaces
cp /boot/opt/interfaces /etc/network/
chmod +x /etc/network/interfaces

# Copying rt-wifi-cli.desktop to /usr/share/applications
echo "Reloading rt-wifi-client"
rm -rf /usr/share/applications/rt-wifi-cli.desktop
cp /boot/opt/rt-wifi-cli.desktop /usr/share/applications

# Making it executable
chmod +x /usr/share/applications/rt-wifi-cli.desktop

# Copying chromium-lightweight.desktop to /usr/share/applications
echo "Reloading chromium-lightweight"
rm -rf /usr/share/applications/chromium-lightweight.desktop
cp /boot/opt/chromium-lightweight.desktop /usr/share/applications

# Making it executable
chmod +x /usr/share/applications/chromium-lightweight.desktop

# Copying chromium-lightweight script to /usr/local/bin/
rm -rf /usr/local/bin/chromium-lightweight
cp /boot/opt/chromium-lightweight /usr/local/bin/

# exec rights
# Now you can run  ->  chromium-lightweight  <- from anywhere in the terminal to launch this script
chmod +x /usr/local/bin/chromium-lightweight

# Copying Xcompmgr desktop entry to /etc/xdg/autostart/
echo "Reloading Xcompmgr configs"
rm -rf /etc/xdg/autostart/Xcompmgr.desktop
cp /boot/opt/Xcompmgr.desktop /etc/xdg/autostart/

# Making it executable
chmod +x /etc/xdg/autostart/Xcompmgr.desktop 

# Making a desktop dir to store 
# miscellaneous standalone apps like these
echo "Copying apps to desktop.."
rm -rf /home/pi/Desktop/standalone-apps/
mkdir -p /home/pi/Desktop/standalone-apps

# Copying desktop apps
cp /usr/share/applications/rt-wifi-cli.desktop /home/pi/Desktop/standalone-apps/
cp /usr/share/applications/chromium-lightweight.desktop /home/pi/Desktop/standalone-apps/

# Making all desktop apps executable
chmod +x /home/pi/Desktop/standalone-apps/*.desktop

# Copy wpa_supplicant.service to /etc/systemd/system/
rm -rf /etc/systemd/system/wpa_supplicant.service
cp /boot/opt/wpa_supplicant.service /etc/systemd/system/

###############################################################################################################################################################################################################################################################################################################
### Alternative to /etc/rc.local because it doesn't work by default 
# Disable /etc/rc.local
systemctl disable rc-local.service

#### Final choice of startup-script for now
# Copy custom rc-local.sh to /etc/ 
rm -rm /etc/rc-local.sh
cp /boot/opt/rc-local.sh /etc/
chmod +x /etc/rc-local.sh
#####################################################################################################################################################################

# Reload system daemons
echo "Reloading system daemons"
systemctl daemon-reload;

echo "Enabling wpa_supplicant service....."
# Enable custom rc-local 
systemctl enable wpa_supplicant.service

echo ""
echo ""
echo "Packages installed and configured successfully.."
echo "Reboot now.."

exit 0
