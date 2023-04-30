#! /bin/sh 

echo "Upgrading packages to fulfill unmet dependencies:::";
echo ""
echo ""
apt update;
apt upgrade -y;

## Updating apt-get and installing necessary packages
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
apt-get -y install xinput xinput-calibrator xcompmgr ntp net-tools wireless-tools rfkill build-essential cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev curl vlc python3-vlc libblas-dev libopenblas-dev python3-pil.imagetk xserver-xorg xinit x11-utils x11-touchscreen-calibrator xserver-xorg-input-evdev xscreensaver xscreensaver-gl-extra xscreensaver-data-extra task-lxde-desktop blueman* software-properties-common libavcodec-* alsa-utils libgtk-3-dev ffmpeg libglvnd0 xvkbd onboard pm-utils python3-tk chromium xfce4-power-manager  libgles2-mesa-dev libxcb-randr0-dev libxrandr-dev libxcb-xinerama0-dev libxinerama-dev libxcursor-dev libxcb-cursor-dev libxkbcommon-dev xutils-dev xutils-dev libpthread-stubs0-dev libpciaccess-dev libffi-dev x11proto-xext-dev libxcb1-dev libxcb-*dev libssl-dev libgnutls28-dev x11proto-dri2-dev libx11-dev libxcb-glx0-dev libx11-xcb-dev libxext-dev libxdamage-dev libxfixes-dev libva-dev x11proto-randr-dev x11proto-present-dev libelf-dev mesa-utils libvulkan-dev libvulkan1 libassimp-dev libdrm-dev libxshmfence-dev libxxf86vm-dev libunwind-dev libwayland-dev wayland-protocols libwayland-egl-backend-dev valgrind libzstd-dev vulkan-tools git build-essential bison flex ninja-build python3-mako python3-pip cmake g++ make build-essential git dkms;
echo ""
echo ""
echo "Packages installed!"

echo "Purging brltty & firefox....";
echo ""
echo ""
# Purge unnecessary packages
apt-get -y purge brltty *firefox* --autoremove

echo ""

## Setup lightdm-gtk-greeter
# Remove previous lightdm config files
echo "Removing default lightdm configs.."
rm -rf /etc/lightdm/lightdm.conf;
rm -rf /etc/lightdm/lightdm-gtk-greeter.conf;

# Copying adjusted config files
echo "Copying modified lightdm configs.."
cp /boot/firmware/opt/lightdm.conf /etc/lightdm;
cp /boot/firmware/opt/lightdm-gtk-greeter.conf /etc/lightdm;

echo "Lightdm configured, autologin set to user 'pi' "
echo ""
echo ""

# Copying daisy.mp4 to test if vlc works
mkdir -p /home/pi/Videos && cp /boot/firmware/opt/videos/daisy.mp4 /home/pi/Videos

# Copying rt-wifi-cli.desktop to /usr/share/applications
cp /boot/firmware/opt/rt-wifi-cli.desktop /usr/share/applications

# Making it executable
chmod +x /usr/share/applications/rt-wifi-cli.desktop

# Copying chromium-lightweight.desktop to /usr/share/applications
cp /boot/firmware/opt/chromium-lightweight.desktop /usr/share/applications

# Making it executable
chmod +x /usr/share/applications/chromium-lightweight.desktop

# Copying chromium-lightweight script to /usr/local/bin/
cp /boot/firmware/chromium-lightweight /usr/local/bin/

# exec rights
# Now you can run  ->  chromium-lightweight  <- from anywhere in the terminal to launch this script
chmod +x /usr/local/bin/chromium-lightweight

# Copying Xcompmgr desktop entry to /etc/xdg/autostart/
cp /boot/firmware/opt/Xcompmgr.desktop /etc/xdg/autostart/

# Making it executable
chmod +x /etc/xdg/autostart/Xcompmgr.desktop 

# Making a desktop dir to store 
# miscellaneous standalone apps like these
mkdir -p /home/pi/Desktop/standalone-apps

# Copying desktop apps
cp /usr/share/applications/rt-wifi-cli.desktop /home/pi/Desktop/standalone-apps/
cp /usr/share/applications/chromium-lightweight.desktop /home/pi/Desktop/standalone-apps/

# Making all desktop apps executable
chmod +x /home/pi/Desktop/standalone-apps/*.desktop

# Removing previous sudoers
rm -rf /etc/sudoers

# Copying modified /etc/sudoers to run the wifi client without password
cp /boot/firmware/opt/sudoers /etc/sudoers

# Unblock wifi
#echo "Unblocking wifi"
#rfkill unblock wifi;

#####################################################################################################################################################################
# Clear rc.local and add commands to auto connect on boot
#truncate -s 0 /etc/rc.local
#echo "#! /bin/sh -e" >> /etc/rc.local
#echo "rm -rf /var/run/wpa_supplicant/" >> /etc/rc.local
#echo "ip link set mlan0 down" >> /etc/rc.local
#echo "rfkill unblock wifi" >> /etc/rc.local
#echo "ip link set mlan0 up" >> /etc/rc.local
#echo "wpa_supplicant nl80211 -B -i mlan0 -c /etc/wpa_supplicant/wpa_supplicant.conf" >> /etc/rc.local
#echo "dhclient mlan0" >> /etc/rc.local
#echo "exit 0" >> /etc/rc.local

# Remove faulty driver on boot
#if [ -f /usr/share/X11/xorg.conf.d/99-fbturbo.conf ]; then
#    echo "mv /usr/share/X11/xorg.conf.d/99-fbturbo.conf ~" >> /etc/rc.local;
#    echo "fbturbo terminated..starting X-session now";
#fi

# Make rc.local executable
#chmod +x /etc/rc.local

# Enable rc-local service
#systemctl enable rc-local.service

# Disable /etc/rc.local
systemctl disable rc-local.service
###############################################################################################################################################################################################################################################################################################################
# adding custom startup script to init.d 
# Copy startup script to /etc/init.d
cp /boot/firmware/opt/custom-scripts/on-start.sh /etc/init.d/

# Make on-start.sh executable
chmod +x /etc/init.d/on-start.sh

# Create symlinks
update-rc.d on-start.sh defaults

### Alternative to /etc/rc.local because it doesn't work by default 

# Copy rfkill-unblock.service to /etc/systemd/system/
#echo "Copying rfkill-unblock services to systemd" 
#cp /boot/firmware/opt/rfkill-unblock.service /etc/systemd/system/

# Copy my-rc-local.service to /etc/systemd/system/
#cp /boot/firmware/opt/my-rc-local.service /etc/systemd/system/

# Copy wpa_supplicant.service to /etc/systemd/system/
cp /boot/firmware/opt/wpa_supplicant.service /etc/systemd/system/

# Copy rc-local.sh to /usr/local/bin/  and make it executable
#cp /boot/firmware/opt/rc-local.sh /usr/local/bin/ 
#chmod +x /usr/local/bin/rc-local.sh
#####################################################################################################################################################################


#### Final choice of auto-connect for now
# Copy custom rc-local.sh to /etc/ 
cp /boot/firmware/opt/rc-local.sh /etc/
chmod +x /etc/rc-local.sh

# Reload system daemons
echo "Reloading system daemons"
systemctl daemon-reload;

#echo "Enabling custom startup scripts....."
# Enable rfkill-unblock
#systemctl enable rfkill-unblock.service

# Enable custom rc-local 
#systemctl enable my-rc-local.service

# Enable custom rc-local 
systemctl enable wpa_supplicant.service

echo ""
echo ""
echo "Packages installed and configured successfully.."
echo "Reboot now.. and install vulkan if this is the first time you're running this script.."

exit 0
