#! /bin/sh
echo "executing install-vulkan.sh"
####################################################################################
# Connect to network again for stability 
/boot/firmware/opt/bin/rc-local
# Install vulkan for hardware acceleration
# Remove previous install/configs
rm -rf /home/pi/mesa_vulkan;
apt purge meson -y;
pip3 install meson --break-system-packages;
pip3 install mako --break-system-packages;
cd ~;
# Clone repo and build vulkan
git clone -b 20.3 https://gitlab.freedesktop.org/mesa/mesa.git mesa_vulkan;
cd mesa_vulkan;
CFLAGS="-mcpu=cortex-a72 -mfpu=neon-fp-armv8" CXXFLAGS="-mcpu=cortex-a72 -mfpu=neon-fp-armv8" meson --prefix /usr -D platforms=x11 -D vulkan-drivers= -D gallium-drivers=kmsro,v3d,vc4 -D buildtype=release build;
ninja -C build -j4;
ninja -C build install;

echo ""
echo ""
echo "Vulkan Installed successfully!"
####################################################################################
sleep 2
clear
exit 0
