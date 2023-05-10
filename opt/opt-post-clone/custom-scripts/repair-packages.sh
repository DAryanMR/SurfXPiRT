#! /bin/sh

####################################################################################
# Removing lxde desktop from previous installation if any
#echo "Removing previous lxde desktop installation if any"
#apt purge -y task-lxde-desktop --autoremove
#echo ""
#echo ""

#echo "Upgrading packages to fulfill unmet dependencies:::"
#echo ""
#echo ""
#apt update
#apt upgrade -y
#####################
## Updating apt-get and installing necessary packages
#apt-get update
#apt-get -y upgrade
#echo ""
#echo ""
#echo "Successfully upgraded bookworm packages! Now installing new packages.."
#####################
#echo ""
#echo ""
#echo "Started query for packages...."
#echo ""
#echo ""
# apt-get -y install volumeicon-alsa libgl1-mesa-glx arandr pulseaudio pulseaudio-module-bluetooth xserver-xorg-input-libinput libinput-bin libinput-dev xinput xinput-calibrator xcompmgr ntp net-tools wireless-tools rfkill build-essential cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev curl vlc python3-vlc libblas-dev libopenblas-dev python3-pil.imagetk xserver-xorg xinit x11-utils x11-touchscreen-calibrator xserver-xorg-input-evdev xscreensaver xscreensaver-gl-extra xscreensaver-data-extra task-lxde-desktop blueman bluez software-properties-common libavcodec-* alsa-utils libgtk-3-dev ffmpeg libglvnd0 xvkbd onboard pm-utils python3-tk chromium xfce4-power-manager libgles2-mesa-dev libxcb-randr0-dev libxrandr-dev libxcb-xinerama0-dev libxinerama-dev libxcursor-dev libxcb-cursor-dev libxkbcommon-dev xutils-dev xutils-dev libpthread-stubs0-dev libpciaccess-dev libffi-dev x11proto-xext-dev libxcb1-dev libxcb-*dev libssl-dev libgnutls28-dev x11proto-dri2-dev libx11-dev libxcb-glx0-dev libx11-xcb-dev libxext-dev libxdamage-dev libxfixes-dev libva-dev x11proto-randr-dev x11proto-present-dev libelf-dev mesa-utils libvulkan-dev libvulkan1 libassimp-dev libdrm-dev libxshmfence-dev libxxf86vm-dev libunwind-dev libwayland-dev wayland-protocols libwayland-egl-backend-dev valgrind libzstd-dev vulkan-tools git build-essential bison flex ninja-build python3-mako python3-pip cmake g++ make build-essential git dkms
# apt-get -y install locales volumeicon-alsa libgl1-mesa-glx arandr pulseaudio pulseaudio-module-bluetooth xserver-xorg-input-libinput libinput-bin libinput-dev xinput xinput-calibrator xcompmgr ntp net-tools wireless-tools rfkill build-essential cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev curl vlc python3-vlc libblas-dev libopenblas-dev python3-pil.imagetk xserver-xorg xinit x11-utils x11-touchscreen-calibrator xserver-xorg-input-evdev xscreensaver xscreensaver-gl-extra xscreensaver-data-extra task-xfce-desktop blueman bluez software-properties-common libavcodec-* alsa-utils libgtk-3-dev ffmpeg libglvnd0 xvkbd onboard pm-utils python3-tk chromium xfce4-power-manager libgles2-mesa-dev libxcb-randr0-dev libxrandr-dev libxcb-xinerama0-dev libxinerama-dev libxcursor-dev libxcb-cursor-dev libxkbcommon-dev xutils-dev xutils-dev libpthread-stubs0-dev libpciaccess-dev libffi-dev x11proto-xext-dev libxcb1-dev libxcb-*dev libssl-dev libgnutls28-dev x11proto-dri2-dev libx11-dev libxcb-glx0-dev libx11-xcb-dev libxext-dev libxdamage-dev libxfixes-dev libva-dev x11proto-randr-dev x11proto-present-dev libelf-dev mesa-utils libvulkan-dev libvulkan1 libassimp-dev libdrm-dev libxshmfence-dev libxxf86vm-dev libunwind-dev libwayland-dev wayland-protocols libwayland-egl-backend-dev valgrind libzstd-dev vulkan-tools git build-essential bison flex ninja-build python3-mako python3-pip cmake g++ make build-essential git dkms
#echo ""
#echo ""
#echo "Packages installed!"
#####################
#echo "Purging brltty & firefox...."
#echo ""
#echo ""
# Purge unnecessary packages
#apt-get -y purge brltty *firefox* --autoremove
#echo ""

####################################################################################
# Copying background images to /usr/share/backgrounds
#rm -rf /usr/share/backgrounds/d_bg.jpg && rm -rf /usr/share/backgrounds/lockscreen.jpg
#echo "Copying Desktop backgrounds"
#cp -r /boot/opt/images/backgrounds/* /usr/share/backgrounds/

# Copying desktop apps to /usr/share/applications
echo "Removing previous rt-wifi-cli from applications"
rm -rf /usr/share/applications/rt-wifi-cli.desktop
echo "Copying new rt-wifi-cli to applications"
cp /boot/opt/d_apps/rt-wifi-cli.desktop /usr/share/applications
chmod -R +x /usr/share/applications/

# Copying desktop apps to /home/pi/Desktop
echo "Removing previous rt-wifi-cli from Desktop"
rm -rf /home/pi/Desktop/standalone-apps/rt-wifi-cli.desktop
echo "Copying rt-wifi-cli to Desktop"

cp /boot/opt/d_apps/rt-wifi-cli.desktop /home/pi/Desktop/standalone-apps
# Making all desktop apps executable
chmod -R +x /home/pi/Desktop/standalone-apps/

# Copying scripts to /usr/local/bin/
#rm -rf /usr/local/bin/chromium-lightweight && rm -rf /usr/local/bin/pingman
#echo "Copying Executable scripts to /usr/local/bin"
#cp -r /boot/opt/bin/chromium-lightweight /usr/local/bin/
#cp -r /boot/opt/bin/pingman /usr/local/bin/
# exec rights
# chmod -R +x /usr/local/bin/
#echo "Now you can run  -> chromium-lightweight, pingman <- commands from anywhere in the terminal to launch these scripts"

# Copy exceptional scripts to /etc
#rm -rf /etc/clone-disk-par.sh
#rm -rf /etc/load-supp-drivers.sh
#echo "Copying exceptional scripts to /etc"
#cp -r /boot/opt/custom-scripts/exceptionals/* /etc
# chmod -R +x /etc/

# Copying autostart entries to /etc/xdg/autostart/
#rm -rf /etc/xdg/autostart/Xcompmgr.desktop
#echo "Copying autostart entries to /etc/xdg/autostart"
#cp /boot/opt/autostart/* /etc/xdg/autostart/
# # Making it executable
# chmod -R +x /etc/xdg/autostart/

# Copying ARandr display orientations
#echo "Copying ARandr display orientations"
#rm -rf /home/pi/.screenlayout
#mkdir -p /home/pi/.screenlayout && cp -r /boot/opt/screen_layouts/* /home/pi/.screenlayout/
#chmod -R +x /home/pi/.screenlayout/

# Copying daisy.mp4 to test if vlc works
#echo "Copying daisy.mp4 for video playback test"
#rm -rf /home/pi/Videos
#mkdir -p /home/pi/Videos && cp /boot/opt/videos/daisy.mp4 /home/pi/Videos

# Modify sudoers to execute PiRT-WiFi-Client without password
#echo "Getting rights to execute PiRT-Wifi-Client without password"
# Removing previous sudoers
#rm -rf /etc/sudoers
# Copying modified /etc/sudoers to run the wifi client without password
#cp /boot/opt/sudoers /etc/sudoers
#chmod +x /etc/sudoers

# Copy systemd services
#rm -rf /etc/systemd/system/my-rc-local.service
#rm -rf /etc/systemd/system/wpa_supplicant.service
#echo "Copying systemd services"
#cp -r /boot/opt/systemd/* /etc/systemd/system/

# Copy modules to /etc
#echo "Copying auto-loading modules..."
#rm -rf /etc/modules
#cp /boot/opt/custom-scripts/modules /etc
#chmod +x /etc/modules

# # Disable failed/unnecessary services
# echo "Disabling failed/unnecessary services.."
# echo ""
# echo ""
# systemctl disable rc-local.service
# #systemctl disable connman-wait-online.service
# #systemctl disable osspd.service
# systemctl mask systemd-binfmt.service

# Reload system daemons
#echo "Reloading system daemons"
#systemctl daemon-reload

# Enable systemd-networkd service
#echo "Enabling systemd-networkd service"
#systemctl enable systemd-networkd.service

# Enable wpa_sup service
#echo "Enabling wpa_supplicant service"
#systemctl enable wpa_supplicant.service

# Enable custom rc-local
#echo "Enabling my-rc-local services"
#systemctl enable my-rc-local.service

# ## Setup lightdm-gtk-greeter
# echo "Copying modified lightdm configs.."
# # Remove previous lightdm config files
# rm -rf /etc/lightdm/lightdm*
# # Copying adjusted config files
# cp -r /boot/opt/lightdm/* /etc/lightdm
# echo "Lightdm configured, autologin set to user 'pi' "
# echo ""
# echo ""

# # Copy adjusted raspi-firmware to fs
# echo "Updating GPU driver"
# rm -rf /etc/default/raspi-firmware
# cp /boot/opt/raspi-firmware /etc/default/

# # Copy adjusted config.txt to /boot
# rm -rf /boot/config.txt
# cp /boot/opt/config.txt /boot/

# Copy update-surfxpirt to /usr/local/bin
#rm -rf /usr/local/bin/update-surfxpirt
#echo "Copying surfxpirt-update-manager..."
#cp /boot/opt/update_manager/* /usr/local/bin
#echo "Now you can run 'sudo update-surfxpirt' (after cloning to eMMC) to get latest updates for your Surface RT"

# # Generating initrd.img
# echo "Generating 5.17-rc3 initrd.img"
# cp /boot/zImage /boot/initrd.img-5.17.x.x-armmp
# mv /boot/initrd.img-6.0.0-6-armmp /boot/initrd.img-6.0.0-6-armmp.bak
# mv /boot/initrd.img-6.1.0-7-armmp /boot/initrd.img-6.1.0-7-armmp.bak
# update-initramfs -u -k all

echo ""
echo ""
echo "Packages reconfigured successfully.."

exit 0
