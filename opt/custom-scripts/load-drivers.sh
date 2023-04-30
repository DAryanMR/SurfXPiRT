#! /bin/sh -e

# Disable systemd-udev-settle
systemctl disable systemd-udev-settle.service

# Remove ifupdown
apt purge ifupdown -y --autoremove

# Remove previous interfaces and replace it with a proper one
rm -rf /etc/network/interfaces
rm -rf /etc/wpa_supplicant/wpa_supplicant.conf
cp /boot/firmware/opt/interfaces /etc/network/
cp /boot/firmware/opt/wpa_sup.conf /etc/wpa_supplicant/wpa_supplicant.conf

chmod +x /etc/network/interfaces

# Copy mrvl firmwares and modules to /lib/
mkdir -p /lib/firmware/mrvl
#cp -r /boot/firmware/opt/{firmware/mrvl,modules/5.17.0-rc3-next-20220207-g5bd2d473f01f} /lib
cp -r /boot/firmware/opt/firmware/mrvl/* /lib/firmware/mrvl
cp -r /boot/firmware/opt/modules/5.17.0-rc3-next-20220207-g5bd2d473f01f /lib/modules

# Load Drivers
echo "Loading modules..."
for module in \
    /lib/modules/5.17.0-rc3-next-20220207-g5bd2d473f01f/kernel/drivers/bluetooth/*.ko \
    /lib/modules/5.17.0-rc3-next-20220207-g5bd2d473f01f/kernel/drivers/gpu/drm/*.ko \
    /lib/modules/5.17.0-rc3-next-20220207-g5bd2d473f01f/kernel/drivers/gpu/drm/i2c/*.ko \
    /lib/modules/5.17.0-rc3-next-20220207-g5bd2d473f01f/kernel/drivers/gpu/drm/ttm/ttm.ko \
    /lib/modules/5.17.0-rc3-next-20220207-g5bd2d473f01f/kernel/drivers/i2c/busses/i2c-cros-ec-tunnel.ko \
    /lib/modules/5.17.0-rc3-next-20220207-g5bd2d473f01f/kernel/drivers/input/mouse/elan_i2c.ko \
    /lib/modules/5.17.0-rc3-next-20220207-g5bd2d473f01f/kernel/drivers/media/dvb-frontends/*.ko \
    /lib/modules/5.17.0-rc3-next-20220207-g5bd2d473f01f/kernel/drivers/media/dvb-frontends/cxd2880/cxd2880.ko \
    /lib/modules/5.17.0-rc3-next-20220207-g5bd2d473f01f/kernel/drivers/media/dvb-frontends/drx39xyj/drx39xyj.ko \
    /lib/modules/5.17.0-rc3-next-20220207-g5bd2d473f01f/kernel/drivers/media/spi/cxd2880-spi.ko \
    /lib/modules/5.17.0-rc3-next-20220207-g5bd2d473f01f/kernel/drivers/media/tuners/*.ko \
    /lib/modules/5.17.0-rc3-next-20220207-g5bd2d473f01f/kernel/drivers/net/wireless/broadcom/brcm80211/brcmfmac/brcmfmac.ko \
    /lib/modules/5.17.0-rc3-next-20220207-g5bd2d473f01f/kernel/drivers/net/wireless/broadcom/brcm80211/brcmutil/brcmutil.ko \
    /lib/modules/5.17.0-rc3-next-20220207-g5bd2d473f01f/kernel/drivers/net/wireless/marvell/mwifiex/*.ko \
    /lib/modules/5.17.0-rc3-next-20220207-g5bd2d473f01f/kernel/drivers/platform/chrome/*.ko \
    /lib/modules/5.17.0-rc3-next-20220207-g5bd2d473f01f/kernel/drivers/thermal/tegra/*.ko
do
    insmod $module
    echo "Loaded module: $(basename $module)"
done

echo ""
echo "Drivers loaded. You can cross still run it again to cross check, then Reboot and run 'wifi-setup.sh'." 
exit 0
